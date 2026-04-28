package com.bytebistro.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    // Method to hash password using SHA-256
    public static String hashPassword(String plainPassword) {
        try {
            // Create SHA-256 digest instance
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Convert password string to bytes and hash it
            byte[] hashedBytes = md.digest(plainPassword.getBytes());

            // Convert hashed bytes to hexadecimal string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password: " + e.getMessage());
        }
    }

    // Method to verify entered password against stored hash
    public static boolean verifyPassword(String plainPassword, String storedHash) {
        String hashedInput = hashPassword(plainPassword);
        return hashedInput.equals(storedHash);
    }
}