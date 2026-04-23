package com.bytebistro.menu.model;

public class MenuItem {
    private int itemId;
    private String name;
    private String description;
    private double price;
    private String itemType;
    private boolean isAvailable;

    public MenuItem(int itemId, String name, String description, double price, String itemType, boolean isAvailable) {
        this.itemId = itemId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.itemType = itemType;
        this.isAvailable = isAvailable;
    }

    public MenuItem() {}

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }
}
