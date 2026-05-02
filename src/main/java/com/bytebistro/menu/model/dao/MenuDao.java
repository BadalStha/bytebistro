package com.bytebistro.menu.model.dao;

import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.utils.DBConnection;
import com.mysql.cj.xdevapi.DbDoc;

import java.awt.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDao {

    public static boolean insertItem(MenuItem menuObj) throws SQLException{
        String query = "INSERT INTO menu_item (name, description, price, item_type, is_available) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, menuObj.getName());
            st.setString(2, menuObj.getDescription());
            st.setDouble(3, menuObj.getPrice());
            st.setString(4, menuObj.getItemType());
            st.setBoolean(5, menuObj.isAvailable());

            int insertedRows = st.executeUpdate();
            if (insertedRows == 0) {
                return false;
            } else {
                return true;
            }
        }
    }

    public static List<MenuItem> fetchMenu() throws SQLException{
        String query = "SELECT * FROM menu_items";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {

            ResultSet rs = st.executeQuery();

            List<MenuItem> items = new ArrayList<>();

            while (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String description = rs.getString(3);
                double price = rs.getDouble(4);
                String itemType = rs.getString(5);
                boolean isAvailable = rs.getBoolean(6);

                MenuItem m = new MenuItem(id, name, description, price, itemType, isAvailable);
                items.add(m);
            }
            return items;
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

    public static boolean updateItem(MenuItem item) throws SQLException{
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

    public boolean deleteItem(int id) throws SQLException{
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

    public List<MenuItem> searchItems(String keyword) throws SQLException{
        //List<MenuItem> items = new
        String query = "SELECT * FROM menu_items WHERE name LIKE ? OR item_type LIKE ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement st = conn.prepareStatement(query)) {
            st.setString(1, "%" + keyword + "%");
            st.setString(2, "%" + keyword + "%");

            ResultSet rs = st.executeQuery();

            List<MenuItem> items = new ArrayList<>();

            while (rs.next()) {
                int id = rs.getInt("item_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String itemType = rs.getString("item_type");
                boolean isAvailable = rs.getBoolean("is_available");

                MenuItem m = new MenuItem(id, name, description, price, itemType, isAvailable);
                items.add(m);

            }
            return items;
        }
    }
    // Method to get all available menu items
    public List<MenuItem> getAvailableMenuItems() {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = "SELECT * FROM menu_items WHERE is_available = true ORDER BY item_type ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MenuItem item = new MenuItem();
                item.setItemId(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setItemType(rs.getString("item_type"));
                item.setAvailable(rs.getBoolean("is_available"));
                menuItems.add(item);
            }

        } catch (Exception e) {
            System.out.println("Error fetching menu items: " + e.getMessage());
        }
        return menuItems;
    }

    // Method to get single menu item by ID
    public MenuItem getMenuItemById(int itemId) {
        String sql = "SELECT * FROM menu_items WHERE item_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                MenuItem item = new MenuItem();
                item.setItemId(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setItemType(rs.getString("item_type"));
                item.setAvailable(rs.getBoolean("is_available"));
                return item;
            }

        } catch (Exception e) {
            System.out.println("Error fetching menu item: " + e.getMessage());
        }
        return null;
    }
}


