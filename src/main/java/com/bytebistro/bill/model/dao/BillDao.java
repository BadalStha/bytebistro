package com.bytebistro.bill.model.dao;

import com.bytebistro.bill.model.Bill;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillDao {
    public static boolean generateBill(Bill bill) throws SQLException {
        String query = "INSERT INTO bills (order_id, total_amount, discount, final_amount, payment_status, payment_method) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, bill.getOrderId());
            st.setDouble(2, bill.getTotalAmount());
            st.setDouble(3, bill.getDiscount());
            st.setDouble(4, bill.getFinalAmount());
            st.setString(5, bill.getPaymentStatus());
            st.setString(6, bill.getPaymentMethod());

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static List<Bill> fetchBills() throws SQLException {
        String query = "SELECT * FROM bills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();
            List<Bill> billList = new ArrayList<>();

            while (rs.next()) {
                int billId = rs.getInt("bill_id");
                int orderId = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                double discount = rs.getDouble("discount");
                double finalAmount = rs.getDouble("final_amount");
                String paymentStatus = rs.getString("payment_status");
                String paymentMethod = rs.getString("payment_method");
                String generatedAt = rs.getString("generated_at");

                Bill b = new Bill(billId, orderId, totalAmount, discount, finalAmount, paymentStatus, paymentMethod, generatedAt);
                billList.add(b);
            }
            return billList;
        }
    }

    public static Bill fetchBillById(int id) throws SQLException {
        String query = "SELECT * FROM bills WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int orderId = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                double discount = rs.getDouble("discount");
                double finalAmount = rs.getDouble("final_amount");
                String paymentStatus = rs.getString("payment_status");
                String paymentMethod = rs.getString("payment_method");
                String generatedAt = rs.getString("generated_at");
                return new Bill(id, orderId, totalAmount, discount, finalAmount, paymentStatus, paymentMethod, generatedAt);
            }
            return null;
        }
    }

    public static Bill fetchBillByOrderId(int orderId) throws SQLException {
        String query = "SELECT * FROM bills WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int billId = rs.getInt("bill_id");
                double totalAmount = rs.getDouble("total_amount");
                double discount = rs.getDouble("discount");
                double finalAmount = rs.getDouble("final_amount");
                String paymentStatus = rs.getString("payment_status");
                String paymentMethod = rs.getString("payment_method");
                String generatedAt = rs.getString("generated_at");
                return new Bill(billId, orderId, totalAmount, discount, finalAmount, paymentStatus, paymentMethod, generatedAt);
            }
            return null;
        }
    }

    public static boolean updatePaymentStatus(int billId, String status) throws SQLException {
        String query = "UPDATE bills SET payment_status = ? WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, status);
            st.setInt(2, billId);

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static double fetchTotalRevenue() throws SQLException {
        String query = "SELECT SUM(final_amount) as total FROM bills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
            return 0;
        }
    }

    public static double fetchDailyRevenue(String date) throws SQLException {
        String query = "SELECT SUM(final_amount) as total FROM bills WHERE DATE(generated_at) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, date);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
            return 0;
        }
    }

    public static List<Bill> fetchBillsByDateRange(String fromDate, String toDate) throws SQLException {
        String query = "SELECT * FROM bills WHERE DATE(generated_at) BETWEEN ? AND ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, fromDate);
            st.setString(2, toDate);

            ResultSet rs = st.executeQuery();
            List<Bill> billList = new ArrayList<>();

            while (rs.next()) {
                int billId = rs.getInt("bill_id");
                int orderId = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                double discount = rs.getDouble("discount");
                double finalAmount = rs.getDouble("final_amount");
                String paymentStatus = rs.getString("payment_status");
                String paymentMethod = rs.getString("payment_method");
                String generatedAt = rs.getString("generated_at");

                Bill b = new Bill(billId, orderId, totalAmount, discount, finalAmount, paymentStatus, paymentMethod, generatedAt);
                billList.add(b);
            }
            return billList;
        }
    }

}
