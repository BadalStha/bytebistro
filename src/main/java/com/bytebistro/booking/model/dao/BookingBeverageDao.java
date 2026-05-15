package com.bytebistro.booking.model.dao;

import com.bytebistro.booking.model.BookingBeverage;
import com.bytebistro.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingBeverageDao {

    // Method to save a booking beverage
    public boolean saveBeverage(BookingBeverage beverage) {
        String sql = "INSERT INTO booking_beverages " +
                "(booking_id, item_id, quantity) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, beverage.getBookingId());
            ps.setInt(2, beverage.getItemId());
            ps.setInt(3, beverage.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error saving beverage: " +
                    e.getMessage());
        }
        return false;
    }

    // Method to save multiple beverages
    // for a booking at once
    public boolean saveAllBeverages(List<BookingBeverage> beverages) {
        String sql = "INSERT INTO booking_beverages " +
                "(booking_id, item_id, quantity) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (BookingBeverage bev : beverages) {
                ps.setInt(1, bev.getBookingId());
                ps.setInt(2, bev.getItemId());
                ps.setInt(3, bev.getQuantity());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            for (int result : results) {
                if (result <= 0) return false;
            }
            return true;

        } catch (Exception e) {
            System.out.println("Error saving beverages: " +
                    e.getMessage());
        }
        return false;
    }

    // Method to get all beverages for
    // a specific booking
    public List<BookingBeverage> getBeveragesByBookingId(int bookingId) {
        List<BookingBeverage> beverages = new ArrayList<>();
        String sql = "SELECT bb.*, mi.name AS item_name, " +
                "mi.price AS item_price " +
                "FROM booking_beverages bb " +
                "JOIN menu_items mi ON bb.item_id = mi.item_id " +
                "WHERE bb.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingBeverage bev = new BookingBeverage();
                bev.setBookingBeverageId(
                        rs.getInt("booking_beverage_id"));
                bev.setBookingId(rs.getInt("booking_id"));
                bev.setItemId(rs.getInt("item_id"));
                bev.setQuantity(rs.getInt("quantity"));
                bev.setItemName(rs.getString("item_name"));
                bev.setItemPrice(rs.getDouble("item_price"));
                beverages.add(bev);
            }

        } catch (Exception e) {
            System.out.println("Error fetching beverages: " +
                    e.getMessage());
        }
        return beverages;
    }

    // Method to get available beverages
    // from menu_items (wine and whiskey)
    public List<com.bytebistro.menu.model.MenuItem>
    getAvailableBeverages() {
        List<com.bytebistro.menu.model.MenuItem> beverages =
                new ArrayList<>();
        String sql = "SELECT * FROM menu_items " +
                "WHERE is_available = true " +
                "AND (LOWER(item_type) LIKE '%wine%' " +
                "OR LOWER(item_type) LIKE '%whiskey%' " +
                "OR LOWER(item_type) LIKE '%whisky%' " +
                "OR LOWER(item_type) LIKE '%beverage%') " +
                "ORDER BY item_type ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                com.bytebistro.menu.model.MenuItem item =
                        new com.bytebistro.menu.model.MenuItem();
                item.setItemId(rs.getInt("item_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setItemType(rs.getString("item_type"));
                item.setAvailable(rs.getBoolean("is_available"));
                beverages.add(item);
            }

        } catch (Exception e) {
            System.out.println("Error fetching beverages: " +
                    e.getMessage());
        }
        return beverages;
    }

    // Method to calculate total beverage
    // cost for a booking
    public double calculateBeverageTotal(int bookingId) {
        String sql = "SELECT SUM(bb.quantity * mi.price) AS total " +
                "FROM booking_beverages bb " +
                "JOIN menu_items mi ON bb.item_id = mi.item_id " +
                "WHERE bb.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Error calculating total: " +
                    e.getMessage());
        }
        return 0.0;
    }
}