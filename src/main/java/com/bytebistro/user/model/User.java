package com.bytebistro.user.model;

import java.sql.Timestamp;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String passwordHash;
    private String role;
    private Timestamp createdAt;

    // Default constructor
    public User() {}

    // Parameterized constructor
    public User(int userId, String fullName, String email, String phone,
                String passwordHash, String role, Timestamp createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.role = role;
        this.createdAt = createdAt;
    }

    // Getters
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getPasswordHash() { return passwordHash; }
    public String getRole() { return role; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setUserId(int userId) { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public void setRole(String role) { this.role = role; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}