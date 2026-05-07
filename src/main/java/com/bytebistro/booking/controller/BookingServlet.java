package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.booking.model.dao.BookingDao;
import com.bytebistro.booking.model.dao.TableInfoDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    // GET - display booking form or booking history
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get session
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");

        String action = req.getParameter("action");

        try {
            if ("history".equals(action)) {
                // Show booking history
                BookingDao bookingDao = new BookingDao();
                List<Booking> bookings = bookingDao.getBookingsByUserId(userId);
                req.setAttribute("bookings", bookings);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);

            } else if ("available".equals(action)) {
                // Get available tables for selected date and time
                String bookingDate = req.getParameter("bookingDate");
                String bookingTime = req.getParameter("bookingTime");
                String guestCount  = req.getParameter("guestCount");

                // Validate date and time
                if (bookingDate == null || bookingDate.trim().isEmpty() ||
                        bookingTime == null || bookingTime.trim().isEmpty()) {
                    req.setAttribute("error", "Please select date and time.");
                    loadAllTables(req);
                    req.getRequestDispatcher("/pages/member/booking-form.jsp")
                            .forward(req, res);
                    return;
                }

                // Get available tables
                TableInfoDao tableInfoDao = new TableInfoDao();
                List<TableInfo> availableTables = tableInfoDao
                        .getAvailableTables(bookingDate, bookingTime);

                req.setAttribute("availableTables", availableTables);
                req.setAttribute("bookingDate", bookingDate);
                req.setAttribute("bookingTime", bookingTime);
                req.setAttribute("guestCount", guestCount);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);

            } else {
                // Show booking form with all tables
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
            }

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

        // Get session
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");

        // Handle cancel booking action
        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            try {
                int bookingId = Integer.parseInt(req.getParameter("bookingId"));
                BookingDao bookingDao = new BookingDao();
                boolean cancelled = bookingDao.cancelBooking(bookingId, userId);

                if (cancelled) {
                    res.sendRedirect(req.getContextPath() +
                            "/booking?action=history&success=Booking cancelled successfully.");
                } else {
                    res.sendRedirect(req.getContextPath() +
                            "/booking?action=history&error=Failed to cancel booking.");
                }
            } catch (Exception e) {
                res.sendRedirect(req.getContextPath() +
                        "/booking?action=history&error=" + e.getMessage());
            }
            return;
        }

        // Get form fields
        String tableIdStr    = req.getParameter("tableId");
        String bookingDate   = req.getParameter("bookingDate");
        String bookingTime   = req.getParameter("bookingTime");
        String guestCountStr = req.getParameter("guestCount");

        // ── Validation ──────────────────────────────────────────────

        // Check empty fields
        if (tableIdStr == null || tableIdStr.trim().isEmpty() ||
                bookingDate == null || bookingDate.trim().isEmpty() ||
                bookingTime == null || bookingTime.trim().isEmpty() ||
                guestCountStr == null || guestCountStr.trim().isEmpty()) {

            req.setAttribute("error", "All fields are required.");
            loadAllTables(req);
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);
            return;
        }

        // Validate guest count is a positive number
        int guestCount;
        try {
            guestCount = Integer.parseInt(guestCountStr);
            if (guestCount <= 0) {
                req.setAttribute("error", "Guest count must be at least 1.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
                return;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid guest count.");
            loadAllTables(req);
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);
            return;
        }

        // Validate booking date is not in the past
        Date today = new Date(System.currentTimeMillis());
        Date selectedDate;
        try {
            selectedDate = Date.valueOf(bookingDate);
            if (selectedDate.before(today)) {
                req.setAttribute("error", "Booking date cannot be in the past.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
                return;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Invalid booking date format.");
            loadAllTables(req);
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);
            return;
        }

        try {
            int tableId = Integer.parseInt(tableIdStr);

            // Check table capacity
            TableInfoDao tableInfoDao = new TableInfoDao();
            TableInfo table = tableInfoDao.getTableById(tableId);

            if (table == null) {
                req.setAttribute("error", "Selected table does not exist.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
                return;
            }

            if (guestCount > table.getSeatingCapacity()) {
                req.setAttribute("error", "Guest count exceeds table capacity of "
                        + table.getSeatingCapacity() + " persons.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
                return;
            }

            // Check table availability for selected date and time
            BookingDao bookingDao = new BookingDao();
            boolean isAvailable = bookingDao.isTableAvailable(
                    tableId, bookingDate, bookingTime);

            if (!isAvailable) {
                req.setAttribute("error",
                        "Selected table is not available for the chosen date and time. " +
                                "Please select a different table or time.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
                return;
            }

            // Create booking object
            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setTableId(tableId);
            booking.setBookingDate(Date.valueOf(bookingDate));
            booking.setBookingTime(Time.valueOf(bookingTime + ":00"));
            booking.setGuestCount(guestCount);

            // Save booking to DB
            int bookingId = bookingDao.createBooking(booking);

            if (bookingId != -1) {
                res.sendRedirect(req.getContextPath() +
                        "/booking?action=history&success=Table booked successfully!");
            } else {
                req.setAttribute("error", "Failed to create booking. Please try again.");
                loadAllTables(req);
                req.getRequestDispatcher("/pages/member/booking-form.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadAllTables(req);
            req.getRequestDispatcher("/pages/member/booking-form.jsp")
                    .forward(req, res);
        }
    }

    // Helper method to load all tables
    private void loadAllTables(HttpServletRequest req) {
        try {
            TableInfoDao tableInfoDao = new TableInfoDao();
            List<TableInfo> tables = tableInfoDao.getAllTables();
            req.setAttribute("tables", tables);
        } catch (Exception e) {
            System.out.println("Error loading tables: " + e.getMessage());
        }
    }
}