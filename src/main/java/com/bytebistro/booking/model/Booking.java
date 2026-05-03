package com.bytebistro.booking.model;

import java.sql.Date;
import java.sql.Time;

public class Booking {

    private int bookingId;
    private int userId;
    private int tableId;
    private Date bookingDate;
    private Time bookingTime;
    private int guestCount;
    private String status;
    private double cancellationFee;

    // Extra fields for display purposes
    private int tableNumber;
    private int seatingCapacity;
    private String fullName;

    // Default constructor
    public Booking() {}

    // Parameterized constructor
    public Booking(int bookingId, int userId, int tableId, Date bookingDate,
                   Time bookingTime, int guestCount, String status,
                   double cancellationFee) {
        this.bookingId       = bookingId;
        this.userId          = userId;
        this.tableId         = tableId;
        this.bookingDate     = bookingDate;
        this.bookingTime     = bookingTime;
        this.guestCount      = guestCount;
        this.status          = status;
        this.cancellationFee = cancellationFee;
    }

    // Getters
    public int getBookingId() { return bookingId; }
    public int getUserId() { return userId; }
    public int getTableId() { return tableId; }
    public Date getBookingDate() { return bookingDate; }
    public Time getBookingTime() { return bookingTime; }
    public int getGuestCount() { return guestCount; }
    public String getStatus() { return status; }
    public double getCancellationFee() { return cancellationFee; }
    public int getTableNumber() { return tableNumber; }
    public int getSeatingCapacity() { return seatingCapacity; }
    public String getFullName() { return fullName; }

    // Setters
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setTableId(int tableId) { this.tableId = tableId; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }
    public void setBookingTime(Time bookingTime) { this.bookingTime = bookingTime; }
    public void setGuestCount(int guestCount) { this.guestCount = guestCount; }
    public void setStatus(String status) { this.status = status; }
    public void setCancellationFee(double cancellationFee) { this.cancellationFee = cancellationFee; }
    public void setTableNumber(int tableNumber) { this.tableNumber = tableNumber; }
    public void setSeatingCapacity(int seatingCapacity) { this.seatingCapacity = seatingCapacity; }
    public void setFullName(String fullName) { this.fullName = fullName; }
}