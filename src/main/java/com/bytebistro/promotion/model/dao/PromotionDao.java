package com.bytebistro.promotion.model.dao;

import com.bytebistro.promotion.model.Promotion;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PromotionDao {
    public static boolean insertPromotion(Promotion promotion) throws SQLException {
        String query = "INSERT INTO promotions (title, description, discount_percent, valid_from, valid_until, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, promotion.getTitle());
            st.setString(2, promotion.getDescription());
            st.setDouble(3, promotion.getDiscountPercent());
            st.setString(4, promotion.getValidFrom());
            st.setString(5, promotion.getValidUntil());
            st.setBoolean(6, promotion.isActive());

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static List<Promotion> fetchPromotions() throws SQLException {
        String query = "SELECT * FROM promotions";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();
            List<Promotion> promotionList = new ArrayList<>();

            while (rs.next()) {
                int promotionId = rs.getInt("promotion_id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                double discountPercent = rs.getDouble("discount_percent");
                String validFrom = rs.getString("valid_from");
                String validUntil = rs.getString("valid_until");
                boolean isActive = rs.getBoolean("is_active");

                Promotion p = new Promotion(promotionId, title, description, discountPercent, validFrom, validUntil, isActive);
                promotionList.add(p);
            }
            return promotionList;
        }
    }

    public static Promotion fetchPromotionById(int id) throws SQLException {
        String query = "SELECT * FROM promotions WHERE promotion_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String title = rs.getString("title");
                String description = rs.getString("description");
                double discountPercent = rs.getDouble("discount_percent");
                String validFrom = rs.getString("valid_from");
                String validUntil = rs.getString("valid_until");
                boolean isActive = rs.getBoolean("is_active");
                return new Promotion(id, title, description, discountPercent, validFrom, validUntil, isActive);
            }
            return null;
        }
    }

    public static boolean updatePromotion(Promotion promotion) throws SQLException {
        String query = "UPDATE promotions SET title=?, description=?, discount_percent=?, valid_from=?, valid_until=?, is_active=? WHERE promotion_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, promotion.getTitle());
            st.setString(2, promotion.getDescription());
            st.setDouble(3, promotion.getDiscountPercent());
            st.setString(4, promotion.getValidFrom());
            st.setString(5, promotion.getValidUntil());
            st.setBoolean(6, promotion.isActive());
            st.setInt(7, promotion.getPromotionId());

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static boolean deactivatePromotion(int id) throws SQLException {
        String query = "UPDATE promotions SET is_active=false WHERE promotion_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static boolean activatePromotion(int id) throws SQLException {
        String query = "UPDATE promotions SET is_active=true WHERE promotion_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);

            int effectedRows = st.executeUpdate();
            return effectedRows > 0;
        }
    }

    public static List<Promotion> fetchActivePromotions() throws SQLException {
        String query = "SELECT * FROM promotions WHERE is_active=true AND CURDATE() BETWEEN valid_from AND valid_until";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();
            List<Promotion> promotionList = new ArrayList<>();

            while (rs.next()) {
                int promotionId = rs.getInt("promotion_id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                double discountPercent = rs.getDouble("discount_percent");
                String validFrom = rs.getString("valid_from");
                String validUntil = rs.getString("valid_until");
                boolean isActive = rs.getBoolean("is_active");

                Promotion p = new Promotion(promotionId, title, description, discountPercent, validFrom, validUntil, isActive);
                promotionList.add(p);
            }
            return promotionList;
        }
    }

}
