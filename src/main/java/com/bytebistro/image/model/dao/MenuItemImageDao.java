package com.bytebistro.image.model.dao;

import com.bytebistro.image.model.Image;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MenuItemImageDao {

    public static boolean insertImage(Image image) throws SQLException {
        String query = "INSERT INTO menu_item images (item_id, image_path, uploaded_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, image.getItemId());
            st.setString(2, image.getImagePath());

            int effectedRows = st.executeUpdate();

            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static Image setImageByItemId(int itemId) throws SQLException {
        String query = "SELECT * FROM menu_item_images WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, itemId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Image image = new Image();
                image.setImageId(rs.getInt("image_id"));
                image.setItemId(rs.getInt("item_id"));
                image.setImagePath(rs.getString("image_path"));
                image.setUploadedAt(rs.getString("uploaded_at"));
                return image;
            }
            return null;
        }
    }

    public static boolean deleteImageByItemID(int itemId) throws SQLException {
        String query = "DELETE FROM menu_item images WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, itemId);
            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }
}
