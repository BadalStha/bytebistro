package com.bytebistro.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth")
public class AuthenticationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            // Get existing session without creating a new one
            HttpSession session = req.getSession(false);

            // Check if user is logged in
            if (session != null && session.getAttribute("userId") != null) {

                // Get role from session
                String role = (String) session.getAttribute("role");

                // Redirect based on role
                if (role.equals("admin")) {
                    res.sendRedirect(req.getContextPath() + "/pages/admin/dashboard.jsp");
                } else if (role.equals("member")) {
                    res.sendRedirect(req.getContextPath() + "/pages/member/dashboard.jsp");
                } else if (role.equals("visitor")) {
                    res.sendRedirect(req.getContextPath() + "/pages/visitor/booking-form.jsp");
                } else {
                    res.sendRedirect(req.getContextPath() + "/login");
                }

            } else {
                // No session found, redirect to login
                res.sendRedirect(req.getContextPath() +
                        "/login?error=Please login to access this page.");
            }

        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Forward POST requests to GET handler
        doGet(req, res);
    }
}