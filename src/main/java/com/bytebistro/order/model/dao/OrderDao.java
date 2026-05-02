package com.bytebistro.order.model.dao;

import com.bytebistro.order.model.Order;
import com.bytebistro.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    // Method to place a new order
    public int placeOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, delivery_address, status) " +
                "VALUES (?, ?, 'pending')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getDeliveryAddress());

            ps.executeUpdate();

            // Get the generated order ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error placing order: " + e.getMessage());
        }
        return -1; // Return -1 if order placement failed
    }

    // Method to get all orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY ordered_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setStatus(rs.getString("status"));
                order.setOrderedAt(rs.getTimestamp("ordered_at"));
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }
        return orders;
    }

    // Method to get single order by order ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setStatus(rs.getString("status"));
                order.setOrderedAt(rs.getTimestamp("ordered_at"));
                return order;
            }

        } catch (Exception e) {
            System.out.println("Error fetching order: " + e.getMessage());
        }
        return null;
    }

    // Method to cancel an order
    public boolean cancelOrder(int orderId, int userId) {
        String sql = "UPDATE orders SET status = 'cancelled' " +
                "WHERE order_id = ? AND user_id = ? AND status = 'pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Error cancelling order: " + e.getMessage());
        }
        return false;
    }
}