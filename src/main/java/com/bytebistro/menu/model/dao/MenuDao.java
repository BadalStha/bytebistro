package com.bytebistro.menu.model.dao;

import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDao {

    public static boolean insertMenuItem(MenuItem item) throws SQLException{
        String query = "INSERT INTO menu_item (name, description, price, item_type, is_available) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, item.getName());
            st.setString(2, item.getDescription());
            st.setDouble(3, item.getPrice());
            st.setString(4, item.getItemType());
            st.setBoolean(5, item.isAvailable());

            int insertedRows = st.executeUpdate();
            if (insertedRows == 0) {
                return false;
            } else {
                return true;
            }
        }
    }

    public static List<MenuItem> fetchMenuItems() throws SQLException{
        String query = "SELECT * FROM menu_items";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();

            List<MenuItem> menuList = new ArrayList<>();

            while (rs.next()) {
                int itemId = rs.getInt(1);
                String name = rs.getString(2);
                String description = rs.getString(3);
                double price = rs.getDouble(4);
                String itemType = rs.getString(5);
                boolean isAvailable = rs.getBoolean(6);

                MenuItem item = new MenuItem(itemId, name, description, price, itemType, isAvailable);
                menuList.add(item);
            }
            return menuList;
        }
    }

    public static MenuItem fetchMenuItemById(int id) throws SQLException{
        String query = "SELECT * FROM menu_items WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {

                int itemId = rs.getInt("item_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String itemType = rs.getString("item_type");
                boolean available = rs.getBoolean("is_available");
                MenuItem item = new MenuItem(itemId, name, description, price, itemType, available);
                return item;

            }
            return null;
        }
    }

    public static boolean updateMenuItem(MenuItem item) throws SQLException{
        String query = "UPDATE menu_items SET name = ?, description = ?, price = ?, item_type = ?, is_available = ? WHERE item_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {

            st.setString(1, item.getName());
            st.setString(2, item.getDescription());
            st.setDouble(3, item.getPrice());
            st.setString(4, item.getItemType());
            st.setBoolean(5, item.isAvailable());
            st.setInt(6, item.getItemId());

            int effectedRows = st.executeUpdate();
            if (effectedRows > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public static boolean deleteMenuItem(int id) throws SQLException{
        String query = "DELETE FROM menu_items WHERE item_id = ?";

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

    public static List<MenuItem> searchMenuItems(String keyword) throws SQLException{

        String query = "SELECT * FROM menu_items WHERE name LIKE ? OR item_type LIKE ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, "%" + keyword + "%");
            st.setString(2, "%" + keyword + "%");

            ResultSet rs = st.executeQuery();

            List<MenuItem> menuList = new ArrayList<>();

            while (rs.next()) {
                int itemId = rs.getInt("item_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String itemType = rs.getString("item_type");
                boolean isAvailable = rs.getBoolean("is_available");

                MenuItem item = new MenuItem(itemId, name, description, price, itemType, isAvailable);
                menuList.add(item);

            }
            return menuList;
        }
    }
}


