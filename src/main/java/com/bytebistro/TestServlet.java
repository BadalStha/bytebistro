package com.bytebistro;

import com.bytebistro.utils.DBConnection;
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                out.println("<h2 style='color:green'>Connection Successful!</h2>");
                conn.close();
            }
        } catch (SQLException e) {
            out.println("<h2 style='color:red'>Connection Failed: " + e.getMessage() + "</h2>");
        }
    }
}