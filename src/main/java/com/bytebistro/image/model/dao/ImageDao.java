package com.bytebistro.image.model.dao;

import com.bytebistro.image.model.Image;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ImageDao {

    public static boolean insertImageDetails(String itemId, String imagePath) throws SQLException {
        String query = "INSERT INTO menu_item_images(item_id, image_path) VALUES(?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)
        ){
            st.setString(1, itemId);
            st.setString(2, imagePath);

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0){
                return true;
            } else {
                return false;
            }
        }
    }


    public static Image getImageByItemId(int itemId) throws SQLException {
        String query = "SELECT * FROM menu_item_images WHERE item_id = ? ORDER BY uploaded_at DESC LIMIT 1";
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

    public static boolean deleteImageByItemId(int itemId) throws SQLException {
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
