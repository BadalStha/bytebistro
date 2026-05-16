package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.booking.model.dao.BookingDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reservations")
public class AdminReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            BookingDao bookingDao = new BookingDao();
            List<Booking> bookings = bookingDao.getAllBookingsWithPayment();
            req.setAttribute("bookings", bookings);

            // Count pending bookings
            long pendingCount = bookings.stream()
                    .filter(b -> "pending".equals(b.getStatus()))
                    .count();
            req.setAttribute("pendingCount", pendingCount);
            req.setAttribute("totalCount", bookings.size());

        } catch (Exception e) {
            req.setAttribute("error", "Error loading reservations: " + e.getMessage());
        }

        req.getRequestDispatcher("/pages/admin/reservations.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String bookingIdStr = req.getParameter("bookingId");

        if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/reservations?error=Invalid booking.");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            BookingDao bookingDao = new BookingDao();

            if ("confirm".equals(action)) {
                boolean result = bookingDao.confirmBooking(bookingId);
                if (result) {
                    resp.sendRedirect(req.getContextPath() +
                            "/admin/reservations?success=Booking #BB-" + bookingId + " confirmed successfully.");
                } else {
                    resp.sendRedirect(req.getContextPath() +
                            "/admin/reservations?error=Failed to confirm booking.");
                }
            } else if ("reject".equals(action)) {
                boolean result = bookingDao.rejectBooking(bookingId);
                if (result) {
                    resp.sendRedirect(req.getContextPath() +
                            "/admin/reservations?success=Booking #BB-" + bookingId + " has been rejected.");
                } else {
                    resp.sendRedirect(req.getContextPath() +
                            "/admin/reservations?error=Failed to reject booking.");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/reservations?error=Unknown action.");
            }

        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() +
                    "/admin/reservations?error=" + e.getMessage());
        }
    }
}
