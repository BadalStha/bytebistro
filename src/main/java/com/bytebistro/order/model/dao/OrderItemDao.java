package com.bytebistro.order.model.dao;

import com.bytebistro.order.model.OrderItem;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDao {
    public static List<OrderItem> fetchOrderItems(int orderId) throws SQLException {
        String query = "SELECT * FROM order_items WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, orderId);

            ResultSet rs = st.executeQuery();
            List<OrderItem> itemList = new ArrayList<>();

            while (rs.next()) {
                int orderItemId = rs.getInt("order_item_id");
                int itemId = rs.getInt("item_id");
                int quantity = rs.getInt("quantity");
                double unitPrice = rs.getDouble("unit_price");

                OrderItem oi = new OrderItem(orderItemId, orderId, itemId, quantity, unitPrice);
                itemList.add(oi);
            }
            return itemList;
        }
    }

    public static OrderItem fetchOrderItemById(int id) throws SQLException {
        String query = "SELECT * FROM order_items WHERE order_item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int orderId = rs.getInt("order_id");
                int itemId = rs.getInt("item_id");
                int quantity = rs.getInt("quantity");
                double unitPrice = rs.getDouble("unit_price");
                return new OrderItem(id, orderId, itemId, quantity, unitPrice);
            }
            return null;
        }
    }

}
