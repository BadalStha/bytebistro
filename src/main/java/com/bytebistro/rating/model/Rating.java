package com.bytebistro.rating.model;

import java.sql.Timestamp;

public class Rating {

    private int ratingId;
    private int userId;
    private int foodRating;
    private int staffRating;
    private int ambienceRating;
    private String comment;
    private Timestamp ratedAt;

    // Default constructor
    public Rating() {}

    // Parameterized constructor
    public Rating(int ratingId, int userId, int foodRating,
                  int staffRating, int ambienceRating,
                  String comment, Timestamp ratedAt) {
        this.ratingId       = ratingId;
        this.userId         = userId;
        this.foodRating     = foodRating;
        this.staffRating    = staffRating;
        this.ambienceRating = ambienceRating;
        this.comment        = comment;
        this.ratedAt        = ratedAt;
    }

    // Getters
    public int getRatingId() { return ratingId; }
    public int getUserId() { return userId; }
    public int getFoodRating() { return foodRating; }
    public int getStaffRating() { return staffRating; }
    public int getAmbienceRating() { return ambienceRating; }
    public String getComment() { return comment; }
    public Timestamp getRatedAt() { return ratedAt; }

    // Setters
    public void setRatingId(int ratingId) { this.ratingId = ratingId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setFoodRating(int foodRating) { this.foodRating = foodRating; }
    public void setStaffRating(int staffRating) { this.staffRating = staffRating; }
    public void setAmbienceRating(int ambienceRating) { this.ambienceRating = ambienceRating; }
    public void setComment(String comment) { this.comment = comment; }
    public void setRatedAt(Timestamp ratedAt) { this.ratedAt = ratedAt; }
}