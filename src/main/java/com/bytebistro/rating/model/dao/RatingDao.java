package com.bytebistro.rating.model.dao;

import com.bytebistro.rating.model.Rating;
import com.bytebistro.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RatingDao {

    // Method to save a new rating
    public boolean saveRating(Rating rating) {
        String sql = "INSERT INTO ratings (user_id, food_rating, " +
                "staff_rating, ambience_rating, comment) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, rating.getUserId());
            ps.setInt(2, rating.getFoodRating());
            ps.setInt(3, rating.getStaffRating());
            ps.setInt(4, rating.getAmbienceRating());
            ps.setString(5, rating.getComment());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error saving rating: " +
                    e.getMessage());
        }
        return false;
    }

    // Method to check if user has
    // already submitted a rating
    public boolean hasUserRated(int userId) {
        String sql = "SELECT rating_id FROM ratings " +
                "WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            System.out.println("Error checking rating: " +
                    e.getMessage());
        }
        return false;
    }

    // Method to get rating by user ID
    public Rating getRatingByUserId(int userId) {
        String sql = "SELECT * FROM ratings WHERE user_id = ? " +
                "ORDER BY rated_at DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Rating rating = new Rating();
                rating.setRatingId(rs.getInt("rating_id"));
                rating.setUserId(rs.getInt("user_id"));
                rating.setFoodRating(rs.getInt("food_rating"));
                rating.setStaffRating(rs.getInt("staff_rating"));
                rating.setAmbienceRating(rs.getInt("ambience_rating"));
                rating.setComment(rs.getString("comment"));
                rating.setRatedAt(rs.getTimestamp("rated_at"));
                return rating;
            }

        } catch (Exception e) {
            System.out.println("Error fetching rating: " +
                    e.getMessage());
        }
        return null;
    }

    // Method to update existing rating
    public boolean updateRating(Rating rating) {
        String sql = "UPDATE ratings SET food_rating = ?, staff_rating = ?, ambience_rating = ?, comment = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, rating.getFoodRating());
            ps.setInt(2, rating.getStaffRating());
            ps.setInt(3, rating.getAmbienceRating());
            ps.setString(4, rating.getComment());
            ps.setInt(5, rating.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error updating rating: " +
                    e.getMessage());
        }
        return false;
    }


    // Method to get latest reviews with user names
    public List<Rating> getLatestReviews(int limit) {
        List<Rating> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name FROM ratings r " +
                "JOIN users u ON r.user_id = u.user_id " +
                "WHERE r.comment IS NOT NULL AND r.comment != '' " +
                "ORDER BY r.rated_at DESC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rating rating = new Rating();
                rating.setRatingId(rs.getInt("rating_id"));
                rating.setUserId(rs.getInt("user_id"));
                rating.setFoodRating(rs.getInt("food_rating"));
                rating.setStaffRating(rs.getInt("staff_rating"));
                rating.setAmbienceRating(rs.getInt("ambience_rating"));
                rating.setComment(rs.getString("comment"));
                rating.setRatedAt(rs.getTimestamp("rated_at"));
                rating.setUserName(rs.getString("full_name"));
                reviews.add(rating);
            }

        } catch (Exception e) {
            System.out.println("Error fetching reviews: " + e.getMessage());
        }
        return reviews;
    }
}