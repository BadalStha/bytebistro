package com.bytebistro.promotion.model;

public class Promotion {
    private int promotionId;
    private String title;
    private String description;
    private double discountPercent;
    private String validFrom;
    private String validUntil;
    private boolean isActive;

    public Promotion() {}

    public Promotion(int promotionId, String title, String description,
                     double discountPercent, String validFrom, String validUntil, boolean isActive) {
        this.promotionId = promotionId;
        this.title = title;
        this.description = description;
        this.discountPercent = discountPercent;
        this.validFrom = validFrom;
        this.validUntil = validUntil;
        this.isActive = isActive;
    }

    public int getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(int promotionId) {
        this.promotionId = promotionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(String validFrom) {
        this.validFrom = validFrom;
    }

    public String getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(String validUntil) {
        this.validUntil = validUntil;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
