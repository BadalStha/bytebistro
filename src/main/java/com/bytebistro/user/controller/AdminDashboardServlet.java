package com.bytebistro.user.controller;

import com.bytebistro.menu.model.dao.MenuDao;
import com.bytebistro.order.model.Order;
import com.bytebistro.order.model.dao.OrderDao;
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
            // 1. Total Orders
            List<Order> allOrders = OrderDao.fetchOrders();
            req.setAttribute("totalOrdersCount", allOrders.size());

            // 2. Active Promotions
            int activePromos = PromotionDao.fetchActivePromotions().size();
            req.setAttribute("activePromosCount", activePromos);

            // 4. Total Menu Items
            int totalMenuItems = MenuDao.fetchMenuItems().size();
            req.setAttribute("menuItemsCount", totalMenuItems);

            // 5. Recent Orders (Last 5)
            List<Order> recentOrders = allOrders.size() > 5 
                ? allOrders.subList(allOrders.size() - 5, allOrders.size()) 
                : allOrders;
            req.setAttribute("recentOrders", recentOrders);

        } catch (Exception e) {
            req.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }

        req.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(req, resp);
    }
}
