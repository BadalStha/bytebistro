package com.bytebistro.booking.model.dao;

import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableInfoDao {

    // Method to get all tables
    public List<TableInfo> getAllTables() {
        List<TableInfo> tables = new ArrayList<>();
        String sql = "SELECT * FROM table_info ORDER BY table_number ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TableInfo table = new TableInfo();
                table.setTableId(rs.getInt("table_id"));
                table.setTableNumber(rs.getInt("table_number"));
                table.setSeatingCapacity(rs.getInt("seating_capacity"));
                tables.add(table);
            }

        } catch (Exception e) {
            System.out.println("Error fetching tables: " + e.getMessage());
        }
        return tables;
    }

    // Method to get available tables for a
    // specific date and time
    public List<TableInfo> getAvailableTables(String bookingDate,
                                              String bookingTime) {
        List<TableInfo> tables = new ArrayList<>();
        String sql = "SELECT * FROM table_info " +
                "WHERE table_id NOT IN ( " +
                "    SELECT table_id FROM bookings " +
                "    WHERE booking_date = ? " +
                "    AND booking_time = ? " +
                "    AND status != 'cancelled' " +
                ") ORDER BY table_number ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, bookingDate);
            ps.setString(2, bookingTime);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TableInfo table = new TableInfo();
                table.setTableId(rs.getInt("table_id"));
                table.setTableNumber(rs.getInt("table_number"));
                table.setSeatingCapacity(rs.getInt("seating_capacity"));
                tables.add(table);
            }

        } catch (Exception e) {
            System.out.println("Error fetching available tables: " + e.getMessage());
        }
        return tables;
    }

    // Method to get table by ID
    public TableInfo getTableById(int tableId) {
        String sql = "SELECT * FROM table_info WHERE table_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, tableId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                TableInfo table = new TableInfo();
                table.setTableId(rs.getInt("table_id"));
                table.setTableNumber(rs.getInt("table_number"));
                table.setSeatingCapacity(rs.getInt("seating_capacity"));
                return table;
            }

        } catch (Exception e) {
            System.out.println("Error fetching table: " + e.getMessage());
        }
        return null;
    }

    // Method to get tables by seating capacity
    // useful for filtering tables by guest count
    public List<TableInfo> getTablesByCapacity(int guestCount) {
        List<TableInfo> tables = new ArrayList<>();
        String sql = "SELECT * FROM table_info " +
                "WHERE seating_capacity >= ? " +
                "ORDER BY seating_capacity ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, guestCount);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TableInfo table = new TableInfo();
                table.setTableId(rs.getInt("table_id"));
                table.setTableNumber(rs.getInt("table_number"));
                table.setSeatingCapacity(rs.getInt("seating_capacity"));
                tables.add(table);
            }

        } catch (Exception e) {
            System.out.println("Error fetching tables by capacity: " + e.getMessage());
        }
        return tables;
    }
}