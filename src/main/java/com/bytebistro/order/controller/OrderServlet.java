package com.bytebistro.order.controller;

import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;
import com.bytebistro.order.model.Order;
import com.bytebistro.order.model.OrderItem;
import com.bytebistro.order.model.dao.OrderDao;
import com.bytebistro.order.model.dao.OrderItemDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/member/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("page");
        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null) {
            resp.sendRedirect("/pages/common/login.jsp");
            return;
        }

        if ("list".equals(action)) {
            try {
                int userId = Integer.parseInt(session.getAttribute("userId").toString());
                List<Order> orderList = OrderDao.fetchOrdersByUser(userId);
                req.setAttribute("orders", orderList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch orders: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/member/order-history.jsp").forward(req, resp);

        } else if ("form".equals(action)) {
            try {
                List<MenuItem> menuItems = MenuDao.fetchMenuItems();
                req.setAttribute("menuItems", menuItems);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch menu: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);

        } else if ("view".equals(action)) {
            try {
                int orderId = Integer.parseInt(req.getParameter("id"));
                Order order = OrderDao.fetchOrderById(orderId);
                List<OrderItem> items = OrderItemDao.fetchOrderItems(orderId);
                req.setAttribute("order", order);
                req.setAttribute("orderItems", items);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch order: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);

        } else {
            try {
                int userId = Integer.parseInt(session.getAttribute("userId").toString());
                List<Order> orderList = OrderDao.fetchOrdersByUser(userId);
                req.setAttribute("orders", orderList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch orders: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/member/order-history.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        if (userObj == null) {
            resp.sendRedirect("/pages/common/login.jsp");
            return;
        }

        if ("place".equals(action)) {
            try {
                int userId = Integer.parseInt(session.getAttribute("userId").toString());
                String deliveryAddress = req.getParameter("deliveryAddress");

                if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
                    req.setAttribute("error", "Delivery address is required");
                    req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                    return;
                }

                Order order = new Order();
                order.setUserId(userId);
                order.setDeliveryAddress(deliveryAddress.trim());
                order.setStatus("pending");
                order.setOrderedAt(new Timestamp(System.currentTimeMillis()).toString());

                // Get order items from request
                String[] itemIds = req.getParameterValues("itemId");
                String[] quantities = req.getParameterValues("quantity");

                if (itemIds == null || itemIds.length == 0) {
                    req.setAttribute("error", "Please select at least one item");
                    req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                    return;
                }

                // Validate and prepare order items
                List<OrderItem> orderItems = new java.util.ArrayList<>();
                double totalAmount = 0;

                for (int i = 0; i < itemIds.length; i++) {
                    if (quantities[i] == null || quantities[i].trim().isEmpty() || Integer.parseInt(quantities[i]) <= 0) {
                        continue;
                    }

                    int itemId = Integer.parseInt(itemIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    MenuItem menuItem = MenuDao.fetchMenuItemById(itemId);
                    if (menuItem == null) {
                        req.setAttribute("error", "Invalid menu item selected");
                        req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                        return;
                    }

                    if (!menuItem.isAvailable()) {
                        req.setAttribute("error", "Item " + menuItem.getName() + " is not available");
                        req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                        return;
                    }

                    OrderItem orderItem = new OrderItem();
                    orderItem.setItemId(itemId);
                    orderItem.setQuantity(quantity);
                    orderItem.setUnitPrice(menuItem.getPrice());

                    orderItems.add(orderItem);
                    totalAmount += (menuItem.getPrice() * quantity);
                }

                if (orderItems.isEmpty()) {
                    req.setAttribute("error", "Please select valid quantities for items");
                    req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                    return;
                }

                // Store order items in session for bill generation
                session.setAttribute("orderItems", orderItems);
                session.setAttribute("totalAmount", totalAmount);
                session.setAttribute("order", order);

                // Redirect to payment page
                resp.sendRedirect("/member/payment?action=checkout");

            } catch (Exception e) {
                req.setAttribute("error", "Failed to place order: " + e.getMessage());
                req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
            }
        } else if ("confirm".equals(action)) {
            try {
                int userId = Integer.parseInt(session.getAttribute("userId").toString());
                Order order = (Order) session.getAttribute("order");
                List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("orderItems");

                if (order == null || orderItems == null || orderItems.isEmpty()) {
                    req.setAttribute("error", "Invalid order data");
                    req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
                    return;
                }

                order.setUserId(userId);
                order.setStatus("pending");
                order.setOrderedAt(new Timestamp(System.currentTimeMillis()).toString());

                // Note: Actual order saving would happen here after payment confirmation
                // This is a placeholder for Member 2 to implement full order persistence

                session.removeAttribute("order");
                session.removeAttribute("orderItems");
                session.removeAttribute("totalAmount");

                resp.sendRedirect("/member/order?page=list");

            } catch (Exception e) {
                req.setAttribute("error", "Failed to confirm order: " + e.getMessage());
                req.getRequestDispatcher("/pages/member/order-form.jsp").forward(req, resp);
            }
        }
    }

}
