package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.booking.model.dao.BookingDao;
import com.bytebistro.booking.model.dao.TableInfoDao;

import com.bytebistro.booking.model.dao.TableInfoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    // GET - display booking form or
    // handle AJAX table availability check
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        try {
            // AJAX request for available tables
            if ("getAvailableTables".equals(action)) {
                String bookingDate = req.getParameter("bookingDate");
                String bookingTime = req.getParameter("bookingTime");

                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                PrintWriter out = res.getWriter();

                if (bookingDate == null || bookingDate.trim().isEmpty() ||
                        bookingTime == null || bookingTime.trim().isEmpty()) {
                    out.print("{\"error\": \"Date and time are required.\"}");
                    out.flush();
                    return;
                }

                TableInfoDao tableDao = new TableInfoDao();
                List<TableInfo> tables = tableDao.getAvailableTables(
                        bookingDate, bookingTime);

                // Build JSON response
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < tables.size(); i++) {
                    TableInfo t = tables.get(i);
                    json.append("{");
                    json.append("\"tableId\":").append(t.getTableId()).append(",");
                    json.append("\"tableNumber\":").append(t.getTableNumber()).append(",");
                    json.append("\"seatingCapacity\":").append(t.getSeatingCapacity());
                    json.append("}");
                    if (i < tables.size() - 1) json.append(",");
                }
                json.append("]");
                out.print(json.toString());
                out.flush();
                return;
            }

            // Load booking history
            BookingDao bookingDao = new BookingDao();
            List<Booking> bookings = bookingDao.getBookingsByUserId(userId);
            int totalBookings = bookingDao.getTotalBookingsByUserId(userId);

            // Load all tables for initial display
            TableInfoDao tableDao = new TableInfoDao();
            List<TableInfo> tables = tableDao.getAllTables();

            req.setAttribute("bookings", bookings);
            req.setAttribute("tables", tables);
            req.setAttribute("totalBookings", totalBookings);
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);
        }
    }

    // POST - handle booking form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        // Handle cancel booking
        if ("cancel".equals(action)) {
            try {
                int bookingId = Integer.parseInt(
                        req.getParameter("bookingId"));
                BookingDao bookingDao = new BookingDao();
                boolean cancelled = bookingDao.cancelBooking(
                        bookingId, userId);

                if (cancelled) {
                    res.sendRedirect(req.getContextPath() +
                            "/booking?success=Booking cancelled successfully.");
                } else {
                    res.sendRedirect(req.getContextPath() +
                            "/booking?error=Failed to cancel booking.");
                }
            } catch (Exception e) {
                res.sendRedirect(req.getContextPath() +
                        "/booking?error=" + e.getMessage());
            }
            return;
        }

        // Get form fields
        String tableIdStr    = req.getParameter("tableId");
        String bookingDate   = req.getParameter("bookingDate");
        String bookingTime   = req.getParameter("bookingTime");
        String guestCountStr = req.getParameter("guestCount");

        // Validate empty fields
        if (tableIdStr == null || tableIdStr.trim().isEmpty() ||
                bookingDate == null || bookingDate.trim().isEmpty() ||
                bookingTime == null || bookingTime.trim().isEmpty() ||
                guestCountStr == null || guestCountStr.trim().isEmpty()) {

            req.setAttribute("error", "All fields are required.");
            loadAndForward(req, res, userId);
            return;
        }

        // Validate guest count
        int guestCount;
        try {
            guestCount = Integer.parseInt(guestCountStr);
            if (guestCount <= 0) {
                req.setAttribute("error",
                        "Guest count must be at least 1.");
                loadAndForward(req, res, userId);
                return;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid guest count.");
            loadAndForward(req, res, userId);
            return;
        }

        // Validate booking date not in past
        try {
            Date today = new Date(System.currentTimeMillis());
            Date selectedDate = Date.valueOf(bookingDate);
            if (selectedDate.before(today)) {
                req.setAttribute("error",
                        "Booking date cannot be in the past.");
                loadAndForward(req, res, userId);
                return;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Invalid date format.");
            loadAndForward(req, res, userId);
            return;
        }

        try {
            int tableId = Integer.parseInt(tableIdStr);

            // Check table exists and capacity
            TableInfoDao tableDao = new TableInfoDao();
            TableInfo table = tableDao.getTableById(tableId);

            if (table == null) {
                req.setAttribute("error", "Selected table does not exist.");
                loadAndForward(req, res, userId);
                return;
            }

            if (guestCount > table.getSeatingCapacity()) {
                req.setAttribute("error",
                        "Guest count exceeds table capacity of " +
                                table.getSeatingCapacity() + " persons.");
                loadAndForward(req, res, userId);
                return;
            }

            // Check table availability
            BookingDao bookingDao = new BookingDao();
            boolean available = bookingDao.isTableAvailable(
                    tableId, bookingDate, bookingTime);

            if (!available) {
                req.setAttribute("error",
                        "Selected table is not available for " +
                                "the chosen date and time.");
                loadAndForward(req, res, userId);
                return;
            }

            // Create booking
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setTableId(tableId);
            booking.setBookingDate(Date.valueOf(bookingDate));
            booking.setBookingTime(Time.valueOf(bookingTime + ":00"));
            booking.setGuestCount(guestCount);

            int bookingId = bookingDao.createBooking(booking);

            if (bookingId != -1) {
                res.sendRedirect(req.getContextPath() +
                        "/booking?success=Table booked successfully!");
            } else {
                req.setAttribute("error",
                        "Failed to create booking. Please try again.");
                loadAndForward(req, res, userId);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadAndForward(req, res, userId);
        }
    }

    // Helper to load data and forward
    private void loadAndForward(HttpServletRequest req,
                                HttpServletResponse res, int userId)
            throws ServletException, IOException {
        try {
            BookingDao bookingDao = new BookingDao();
            TableInfoDao tableDao = new TableInfoDao();
            req.setAttribute("bookings",
                    bookingDao.getBookingsByUserId(userId));
            req.setAttribute("tables", tableDao.getAllTables());
            req.setAttribute("totalBookings",
                    bookingDao.getTotalBookingsByUserId(userId));
        } catch (Exception e) {
            System.out.println("Error loading data: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/member/booking-form.jsp")
                .forward(req, res);
    }
}