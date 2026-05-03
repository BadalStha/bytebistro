package com.bytebistro.booking.model.dao;

import com.bytebistro.booking.model.Booking;
import com.bytebistro.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDao {

    // Method to create a new booking
    public int createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, table_id, booking_date, " +
                "booking_time, guest_count, status) " +
                "VALUES (?, ?, ?, ?, ?, 'pending')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getTableId());
            ps.setDate(3, booking.getBookingDate());
            ps.setTime(4, booking.getBookingTime());
            ps.setInt(5, booking.getGuestCount());

            ps.executeUpdate();

            // Get generated booking ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println("Error creating booking: " + e.getMessage());
        }
        return -1;
    }

    // Method to get all bookings by user ID
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, t.table_number, t.seating_capacity " +
                "FROM bookings b " +
                "JOIN table_info t ON b.table_id = t.table_id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_date DESC, b.booking_time DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setTableId(rs.getInt("table_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setBookingTime(rs.getTime("booking_time"));
                booking.setGuestCount(rs.getInt("guest_count"));
                booking.setStatus(rs.getString("status"));
                booking.setCancellationFee(rs.getDouble("cancellation_fee"));
                booking.setTableNumber(rs.getInt("table_number"));
                booking.setSeatingCapacity(rs.getInt("seating_capacity"));
                bookings.add(booking);
            }

        } catch (Exception e) {
            System.out.println("Error fetching bookings: " + e.getMessage());
        }
        return bookings;
    }

    // Method to get single booking by booking ID
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT b.*, t.table_number, t.seating_capacity " +
                "FROM bookings b " +
                "JOIN table_info t ON b.table_id = t.table_id " +
                "WHERE b.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setTableId(rs.getInt("table_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setBookingTime(rs.getTime("booking_time"));
                booking.setGuestCount(rs.getInt("guest_count"));
                booking.setStatus(rs.getString("status"));
                booking.setCancellationFee(rs.getDouble("cancellation_fee"));
                booking.setTableNumber(rs.getInt("table_number"));
                booking.setSeatingCapacity(rs.getInt("seating_capacity"));
                return booking;
            }

        } catch (Exception e) {
            System.out.println("Error fetching booking: " + e.getMessage());
        }
        return null;
    }

    // Method to check if table is already booked
    // for a given date and time
    public boolean isTableAvailable(int tableId, String bookingDate,
                                    String bookingTime) {
        String sql = "SELECT booking_id FROM bookings " +
                "WHERE table_id = ? " +
                "AND booking_date = ? " +
                "AND booking_time = ? " +
                "AND status != 'cancelled'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, tableId);
            ps.setString(2, bookingDate);
            ps.setString(3, bookingTime);

            ResultSet rs = ps.executeQuery();
            return !rs.next(); // True if no existing booking found

        } catch (Exception e) {
            System.out.println("Error checking availability: " + e.getMessage());
        }
        return false;
    }

    // Method to cancel a booking
    public boolean cancelBooking(int bookingId, int userId) {
        // Calculate cancellation fee based on booking date
        String checkSql = "SELECT booking_date FROM bookings " +
                "WHERE booking_id = ? AND user_id = ? " +
                "AND status = 'pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkSql)) {

            checkPs.setInt(1, bookingId);
            checkPs.setInt(2, userId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                Date bookingDate = rs.getDate("booking_date");
                Date today = new Date(System.currentTimeMillis());

                // Calculate days difference
                long diff = bookingDate.getTime() - today.getTime();
                long daysDiff = diff / (1000 * 60 * 60 * 24);

                // Set cancellation fee based on days remaining
                double cancellationFee = 0.00;
                if (daysDiff <= 1) {
                    cancellationFee = 500.00; // Fee if cancelled within 1 day
                } else if (daysDiff <= 3) {
                    cancellationFee = 250.00; // Fee if cancelled within 3 days
                }

                // Update booking status and cancellation fee
                String updateSql = "UPDATE bookings SET status = 'cancelled', " +
                        "cancellation_fee = ? " +
                        "WHERE booking_id = ? AND user_id = ?";

                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setDouble(1, cancellationFee);
                updatePs.setInt(2, bookingId);
                updatePs.setInt(3, userId);

                int rowsAffected = updatePs.executeUpdate();
                return rowsAffected > 0;
            }

        } catch (Exception e) {
            System.out.println("Error cancelling booking: " + e.getMessage());
        }
        return false;
    }
}