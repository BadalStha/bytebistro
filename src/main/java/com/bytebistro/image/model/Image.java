package com.bytebistro.image.model;

public class Image {
    private int imageId;
    private int itemId;
    private String imagePath;
    private String uploadedAt;

    public Image() {}

    public Image(int imageId, int itemId, String imagePath, String uploadedAt) {
        this.imageId = imageId;
        this.itemId = itemId;
        this.imagePath = imagePath;
        this.uploadedAt = uploadedAt;
    }

    public String getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(String uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }
}
