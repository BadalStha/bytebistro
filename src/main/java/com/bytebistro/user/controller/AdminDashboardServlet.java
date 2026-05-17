package com.bytebistro.user.controller;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.booking.model.dao.BookingDao;
import com.bytebistro.menu.model.dao.MenuDao;
import com.bytebistro.promotion.model.dao.PromotionDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            BookingDao bookingDao = new BookingDao();

            // 1. Total Bookings
            List<Booking> allBookings = bookingDao.getAllBookingsWithPayment();
            req.setAttribute("totalBookingsCount", allBookings.size());

            // 2. Active Promotions
            int activePromos = PromotionDao.fetchActivePromotions().size();
            req.setAttribute("activePromosCount", activePromos);

            // 4. Total Menu Items
            int totalMenuItems = MenuDao.fetchMenuItems().size();
            req.setAttribute("menuItemsCount", totalMenuItems);

            // 5. Recent Bookings (Last 5)
            List<Booking> recentBookings = allBookings.size() > 5
                    ? allBookings.subList(0, 5)
                    : allBookings;
            req.setAttribute("recentBookings", recentBookings);

        } catch (Exception e) {
            req.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }

        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
