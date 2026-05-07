package com.bytebistro.order.model.dao;

import com.bytebistro.order.model.Order;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    public static List<Order> fetchOrders() throws SQLException {
        String query = "SELECT * FROM orders";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();
            List<Order> orderList = new ArrayList<>();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                String deliveryAddress = rs.getString("delivery_address");
                String status = rs.getString("status");
                String orderedAt = rs.getString("ordered_at");

                Order o = new Order(orderId, userId, deliveryAddress, status, orderedAt);
                orderList.add(o);
            }
            return orderList;
        }
    }

    public static Order fetchOrderById(int id) throws SQLException {
        String query = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String deliveryAddress = rs.getString("delivery_address");
                String status = rs.getString("status");
                String orderedAt = rs.getString("ordered_at");
                return new Order(id, userId, deliveryAddress, status, orderedAt);
            }
            return null;
        }
    }

    public static List<Order> fetchOrdersByDate(String date) throws SQLException {
        String query = "SELECT * FROM orders WHERE DATE(ordered_at) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, date);

            ResultSet rs = st.executeQuery();
            List<Order> orderList = new ArrayList<>();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                String deliveryAddress = rs.getString("delivery_address");
                String status = rs.getString("status");
                String orderedAt = rs.getString("ordered_at");

                Order o = new Order(orderId, userId, deliveryAddress, status, orderedAt);
                orderList.add(o);
            }
            return orderList;
        }
    }

    public static List<Order> fetchOrdersByUser(int userId) throws SQLException {
        String query = "SELECT * FROM orders WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, userId);

            ResultSet rs = st.executeQuery();
            List<Order> orderList = new ArrayList<>();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                String deliveryAddress = rs.getString("delivery_address");
                String status = rs.getString("status");
                String orderedAt = rs.getString("ordered_at");

                Order o = new Order(orderId, userId, deliveryAddress, status, orderedAt);
                orderList.add(o);
            }
            return orderList;
        }
    }

}
