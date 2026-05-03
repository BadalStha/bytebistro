package com.bytebistro.order.model.dao;

import com.bytebistro.order.model.OrderItem;
import com.bytebistro.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDao {

    // Method to save a single order item
    public boolean saveOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, item_id, quantity, unit_price) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getItemId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setDouble(4, orderItem.getUnitPrice());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            System.out.println("Error saving order item: " + e.getMessage());
        }
        return false;
    }

    // Method to get all order items by order ID
    // Joins with menu_items to get item name
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT oi.*, mi.name AS item_name " +
                "FROM order_items oi " +
                "JOIN menu_items mi ON oi.item_id = mi.item_id " +
                "WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderItemId(rs.getInt("order_item_id"));
                orderItem.setOrderId(rs.getInt("order_id"));
                orderItem.setItemId(rs.getInt("item_id"));
                orderItem.setQuantity(rs.getInt("quantity"));
                orderItem.setUnitPrice(rs.getDouble("unit_price"));
                orderItem.setItemName(rs.getString("item_name"));
                orderItems.add(orderItem);
            }

        } catch (Exception e) {
            System.out.println("Error fetching order items: " + e.getMessage());
        }
        return orderItems;
    }

    // Method to save multiple order items at once
    public boolean saveAllOrderItems(List<OrderItem> orderItems) {
        String sql = "INSERT INTO order_items (order_id, item_id, quantity, unit_price) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Add all items as batch
            for (OrderItem item : orderItems) {
                ps.setInt(1, item.getOrderId());
                ps.setInt(2, item.getItemId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();
            }

            // Execute all inserts at once
            int[] results = ps.executeBatch();

            // Check all inserts were successful
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            return true;

        } catch (Exception e) {
            System.out.println("Error saving order items: " + e.getMessage());
        }
        return false;
    }

    // Method to calculate total amount of an order
    public double calculateOrderTotal(int orderId) {
        String sql = "SELECT SUM(quantity * unit_price) AS total " +
                "FROM order_items WHERE order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Error calculating total: " + e.getMessage());
        }
        return 0.0;
    }
}