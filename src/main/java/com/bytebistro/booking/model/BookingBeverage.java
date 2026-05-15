package com.bytebistro.booking.model;

public class BookingBeverage {

    private int bookingBeverageId;
    private int bookingId;
    private int itemId;
    private int quantity;

    // Extra fields for display purposes
    private String itemName;
    private double itemPrice;

    // Default constructor
    public BookingBeverage() {}

    // Parameterized constructor
    public BookingBeverage(int bookingBeverageId, int bookingId,
                           int itemId, int quantity) {
        this.bookingBeverageId = bookingBeverageId;
        this.bookingId         = bookingId;
        this.itemId            = itemId;
        this.quantity          = quantity;
    }

    // Getters
    public int getBookingBeverageId() { return bookingBeverageId; }
    public int getBookingId() { return bookingId; }
    public int getItemId() { return itemId; }
    public int getQuantity() { return quantity; }
    public String getItemName() { return itemName; }
    public double getItemPrice() { return itemPrice; }

    // Setters
    public void setBookingBeverageId(int bookingBeverageId) { this.bookingBeverageId = bookingBeverageId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public void setItemPrice(double itemPrice) { this.itemPrice = itemPrice; }

    // Helper method to get total price
    public double getTotalPrice() {
        return quantity * itemPrice;
    }
}