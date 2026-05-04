package com.bytebistro.order.model;

import java.sql.Timestamp;
import java.util.List;

public class Order {

    private int orderId;
    private int userId;
    private String deliveryAddress;
    private String status;
    private Timestamp orderedAt;
    private List<OrderItem> orderItems;
    private double totalAmount;

    // Default constructor
    public Order() {}

    // Parameterized constructor
    public Order(int orderId, int userId, String deliveryAddress,
                 String status, Timestamp orderedAt) {
        this.orderId = orderId;
        this.userId = userId;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.orderedAt = orderedAt;
    }

    // Getters
    public int getOrderId() { return orderId; }
    public int getUserId() { return userId; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public String getStatus() { return status; }
    public Timestamp getOrderedAt() { return orderedAt; }
    public List<OrderItem> getOrderItems() { return orderItems; }
    public double getTotalAmount() { return totalAmount; }

    // Setters
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public void setStatus(String status) { this.status = status; }
    public void setOrderedAt(Timestamp orderedAt) { this.orderedAt = orderedAt; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
}