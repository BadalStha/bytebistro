package com.bytebistro.order.controller;

import com.bytebistro.order.model.Order;
import com.bytebistro.order.model.OrderItem;
import com.bytebistro.order.model.dao.OrderDao;
import com.bytebistro.order.model.dao.OrderItemDao;
import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    // GET - display order form or order history
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get session
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");

        String action = req.getParameter("action");

        try {
            if ("history".equals(action)) {
                // Show order history
                OrderDao orderDao = new OrderDao();
                OrderItemDao orderItemDao = new OrderItemDao();

                // Get all orders for this user
                List<Order> orders = orderDao.getOrdersByUserId(userId);

                // Get order items for each order
                for (Order order : orders) {
                    List<OrderItem> items = orderItemDao
                            .getOrderItemsByOrderId(order.getOrderId());
                    order.setOrderItems(items);

                    // Calculate total for each order
                    double total = orderItemDao
                            .calculateOrderTotal(order.getOrderId());
                    order.setTotalAmount(total);
                }

                req.setAttribute("orders", orders);
                req.getRequestDispatcher("/pages/member/order-history.jsp")
                        .forward(req, res);

            } else {
                // Show order form with available menu items
                MenuDao menuDao = new MenuDao();
                List<MenuItem> menuItems = menuDao.getAvailableMenuItems();
                req.setAttribute("menuItems", menuItems);
                req.getRequestDispatcher("/pages/member/order-form.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/member/order-form.jsp")
                    .forward(req, res);
        }
    }

    // POST - handle order placement
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get session
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("userId");

        // Get form fields
        String deliveryAddress = req.getParameter("deliveryAddress");
        String[] itemIds       = req.getParameterValues("itemId");
        String[] quantities    = req.getParameterValues("quantity");

        // ── Validation ──────────────────────────────────────────────

        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            req.setAttribute("error", "Delivery address is required.");
            loadMenuItems(req);
            req.getRequestDispatcher("/pages/member/order-form.jsp")
                    .forward(req, res);
            return;
        }

        if (itemIds == null || itemIds.length == 0) {
            req.setAttribute("error", "Please select at least one item.");
            loadMenuItems(req);
            req.getRequestDispatcher("/pages/member/order-form.jsp")
                    .forward(req, res);
            return;
        }

        try {
            MenuDao menuDao         = new MenuDao();
            OrderDao orderDao       = new OrderDao();
            OrderItemDao orderItemDao = new OrderItemDao();

            // Build order items list
            List<OrderItem> orderItems = new ArrayList<>();
            for (int i = 0; i < itemIds.length; i++) {
                int itemId   = Integer.parseInt(itemIds[i]);
                int quantity = Integer.parseInt(quantities[i]);

                // Skip items with 0 quantity
                if (quantity <= 0) continue;

                // Get item price from DB
                MenuItem menuItem = menuDao.getMenuItemById(itemId);
                if (menuItem == null) continue;

                OrderItem orderItem = new OrderItem();
                orderItem.setItemId(itemId);
                orderItem.setQuantity(quantity);
                orderItem.setUnitPrice(menuItem.getPrice());
                orderItems.add(orderItem);
            }

            // Check at least one valid item selected
            if (orderItems.isEmpty()) {
                req.setAttribute("error", "Please select at least one item with valid quantity.");
                loadMenuItems(req);
                req.getRequestDispatcher("/pages/member/order-form.jsp")
                        .forward(req, res);
                return;
            }

            // Place the order first to get order ID
            Order order = new Order();
            order.setUserId(userId);
            order.setDeliveryAddress(deliveryAddress.trim());

            int orderId = orderDao.placeOrder(order);

            if (orderId == -1) {
                req.setAttribute("error", "Failed to place order. Please try again.");
                loadMenuItems(req);
                req.getRequestDispatcher("/pages/member/order-form.jsp")
                        .forward(req, res);
                return;
            }

            // Set order ID for each order item
            for (OrderItem item : orderItems) {
                item.setOrderId(orderId);
            }

            // Save all order items
            boolean itemsSaved = orderItemDao.saveAllOrderItems(orderItems);

            if (itemsSaved) {
                // Redirect to order history with success message
                res.sendRedirect(req.getContextPath() +
                        "/order?action=history&success=Order placed successfully!");
            } else {
                req.setAttribute("error", "Failed to save order items. Please try again.");
                loadMenuItems(req);
                req.getRequestDispatcher("/pages/member/order-form.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadMenuItems(req);
            req.getRequestDispatcher("/pages/member/order-form.jsp")
                    .forward(req, res);
        }
        // Handle cancel order action
        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            OrderDao orderDao = new OrderDao();
            boolean cancelled = orderDao.cancelOrder(orderId, userId);
            if (cancelled) {
                res.sendRedirect(req.getContextPath() +
                        "/order?action=history&success=Order cancelled successfully.");
            } else {
                res.sendRedirect(req.getContextPath() +
                        "/order?action=history&error=Failed to cancel order.");
            }
            return;
        }
        // Handle cancel order action
        if ("cancel".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            OrderDao orderDao = new OrderDao();
            boolean cancelled = orderDao.cancelOrder(orderId, userId);
            if (cancelled) {
                res.sendRedirect(req.getContextPath() +
                        "/order?action=history&success=Order cancelled successfully.");
            } else {
                res.sendRedirect(req.getContextPath() +
                        "/order?action=history&error=Failed to cancel order.");
            }
            return;
        }
    }

    // Helper method to load menu items for order form
    private void loadMenuItems(HttpServletRequest req) {
        try {
            MenuDao menuDao = new MenuDao();
            List<MenuItem> menuItems = menuDao.getAvailableMenuItems();
            req.setAttribute("menuItems", menuItems);
        } catch (Exception e) {
            System.out.println("Error loading menu items: " + e.getMessage());
        }
    }
}