package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.booking.model.dao.BookingDao;
import com.bytebistro.booking.model.dao.TableInfoDao;
import com.bytebistro.utils.ImageUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/booking")
@MultipartConfig
public class BookingServlet extends HttpServlet {

    // GET - display booking form or
    // handle AJAX table availability check
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/common/register.jsp");
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

                try {
                    if (bookingDate == null || bookingDate.trim().isEmpty() ||
                            bookingTime == null || bookingTime.trim().isEmpty()) {
                        out.print("{\"error\": \"Date and time are required.\"}");
                        out.flush();
                        return;
                    }

                    TableInfoDao dao = new TableInfoDao();
                    List<TableInfo> tables = dao.getAvailableTables(bookingDate, bookingTime);

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
                } catch (Exception ex) {
                    out.print("{\"error\": \"" + ex.getMessage() + "\"}");
                    out.flush();
                }
                return;
            }

            // Payment page request
            if ("payment".equals(action)) {
                String bookingIdStr = req.getParameter("bookingId");
                if (bookingIdStr != null) {
                    int bookingId = Integer.parseInt(bookingIdStr);
                    BookingDao bookingDao = new BookingDao();
                    Booking booking = bookingDao.getBookingById(bookingId);
                    if (booking != null && booking.getUserId() == userId) {
                        req.setAttribute("booking", booking);
                        req.getRequestDispatcher("/pages/member/booking-payment.jsp")
                                .forward(req, res);
                        return;
                    }
                }
                res.sendRedirect(req.getContextPath() + "/booking?error=Invalid booking.");
                return;
            }

            // Load all data for booking form
            loadFormData(req, userId);
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            e.printStackTrace(); // Log to console for debugging
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);
        }
    }

    // POST - handle booking form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/pages/common/register.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        // Handle payment proof upload
        if ("uploadPayment".equals(action)) {
            handlePaymentUpload(req, res, userId);
            return;
        }

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

        // Beverage parameters removed

        // Validate empty fields
        if (tableIdStr == null || tableIdStr.trim().isEmpty() ||
                bookingDate == null || bookingDate.trim().isEmpty() ||
                bookingTime == null || bookingTime.trim().isEmpty() ||
                guestCountStr == null || guestCountStr.trim().isEmpty()) {

            req.setAttribute("error", "All fields are required.");
            loadFormData(req, userId);
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);
            return;
        }

        // Validate guest count
        int guestCount;
        try {
            guestCount = Integer.parseInt(guestCountStr);
            if (guestCount <= 0) {
                req.setAttribute("error",
                        "Guest count must be at least 1.");
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
                return;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid guest count.");
            loadFormData(req, userId);
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);
            return;
        }

        // Validate booking date not in past
        try {
            Date today = new Date(System.currentTimeMillis());
            Date selectedDate = Date.valueOf(bookingDate);
            if (selectedDate.before(today)) {
                req.setAttribute("error",
                        "Booking date cannot be in the past.");
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
                return;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Invalid date format.");
            loadFormData(req, userId);
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);
            return;
        }

        try {
            int tableId = Integer.parseInt(tableIdStr);

            // Check table exists and capacity
            TableInfoDao TableInfoDao = new TableInfoDao();
            TableInfo table = TableInfoDao.getTableById(tableId);

            if (table == null) {
                req.setAttribute("error",
                        "Selected table does not exist.");
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
                return;
            }

            if (guestCount > table.getSeatingCapacity()) {
                req.setAttribute("error",
                        "Guest count exceeds table capacity of " +
                                table.getSeatingCapacity() + " persons.");
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
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
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
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

            if (bookingId == -1) {
                req.setAttribute("error",
                        "Failed to create booking. Please try again.");
                loadFormData(req, userId);
                req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                        .forward(req, res);
                return;
            }

            // Redirect to payment page instead of success
            res.sendRedirect(req.getContextPath() +
                    "/booking?action=payment&bookingId=" + bookingId);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadFormData(req, userId);
            req.getRequestDispatcher("/pages/member/member-booking-form.jsp")
                    .forward(req, res);
        }
    }

    // Helper to load all form data
    private void loadFormData(HttpServletRequest req, int userId) {
        try {
            BookingDao bookingDao = new BookingDao();
            TableInfoDao tableInfoDao = new TableInfoDao();

            List<Booking> bookings = bookingDao.getBookingsByUserId(userId);
            req.setAttribute("bookings", bookings);
            req.setAttribute("totalBookings", bookings != null ? bookings.size() : 0);
            req.setAttribute("tables", tableInfoDao.getAllTables());

        } catch (Exception e) {
            System.out.println("Error loading form data: " +
                    e.getMessage());
        }
    }

    // Handle payment proof upload
    private void handlePaymentUpload(HttpServletRequest req, HttpServletResponse res,
                                     int userId) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            Part paymentProof = req.getPart("paymentProof");

            if (paymentProof == null || paymentProof.getSize() == 0) {
                BookingDao bookingDao = new BookingDao();
                Booking booking = bookingDao.getBookingById(bookingId);
                req.setAttribute("booking", booking);
                req.setAttribute("error", "Please upload your payment proof.");
                req.getRequestDispatcher("/pages/member/booking-payment.jsp")
                        .forward(req, res);
                return;
            }

            // Save the uploaded image
            String imagePath = ImageUtils.saveImageInDirectory(paymentProof);

            // Save payment proof in database
            BookingDao bookingDao = new BookingDao();
            boolean saved = bookingDao.savePaymentProof(bookingId, imagePath);

            if (saved) {
                res.sendRedirect(req.getContextPath() +
                        "/booking?success=Reservation confirmed! Payment proof submitted for verification.");
            } else {
                Booking booking = bookingDao.getBookingById(bookingId);
                req.setAttribute("booking", booking);
                req.setAttribute("error", "Failed to save payment proof. Please try again.");
                req.getRequestDispatcher("/pages/member/booking-payment.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() +
                    "/booking?error=" + e.getMessage());
        }
    }
}