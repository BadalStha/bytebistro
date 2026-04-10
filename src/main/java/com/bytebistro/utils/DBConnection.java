package com.bytebistro.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    static String URL = "jdbc:mysql://localhost:3306/bytebistro";

    // Database username
    static String USER = "root";

    // Database password
    static String PASSWORD = "1234";

    // Method to get database connection
    public static Connection getConnection() throws SQLException {

        try {
            // Load MySQL JDBC Driver (required for older versions / explicit loading)
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            // Print error if driver is not found
            System.out.println(e.getMessage());
        }

        // Return connection object using DriverManager
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}


