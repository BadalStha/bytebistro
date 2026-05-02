package com.bytebistro.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            // Get existing session without creating a new one
            HttpSession session = req.getSession(false);

            // Invalidate session if it exists
            if (session != null) {
                session.invalidate();
            }

            // Redirect to login page with logout message
            res.sendRedirect(req.getContextPath() + "/login?success=You have been logged out successfully.");

        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}