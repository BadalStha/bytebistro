package com.bytebistro.user.controller;

import com.bytebistro.user.model.User;
import com.bytebistro.user.model.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // GET - display login form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // If already logged in, redirect to appropriate dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            if (role.equals("admin")) {
                res.sendRedirect(req.getContextPath() + "/pages/admin/dashboard.jsp");
            } else if (role.equals("member")) {
                res.sendRedirect(req.getContextPath() + "/pages/member/dashboard.jsp");
            } else {
                res.sendRedirect(req.getContextPath() + "/pages/visitor/booking-form.jsp");
            }
            return;
        }

        // Show success message from registration
        String success = req.getParameter("success");
        if (success != null) {
            req.setAttribute("success", success);
        }

        req.getRequestDispatcher("/pages/common/login.jsp").forward(req, res);
    }

    // POST - handle login form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/pages/common/login.jsp").forward(req, res);
            return;
        }

        try {
            UserDao dao = new UserDao();
            User user = dao.validateLogin(email.trim(), password);

            if (user != null) {
                // Create session and store user details
                HttpSession session = req.getSession();
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());
                session.setMaxInactiveInterval(30 * 60);

                // Redirect based on role
                if (user.getRole().equals("admin")) {
                    res.sendRedirect(req.getContextPath() + "/pages/admin/dashboard.jsp");
                } else if (user.getRole().equals("member")) {
                    res.sendRedirect(req.getContextPath() + "/pages/member/dashboard.jsp");
                } else {
                    res.sendRedirect(req.getContextPath() + "/pages/visitor/booking-form.jsp");
                }

            } else {
                // Invalid credentials
                req.setAttribute("error", "Invalid email or password. Please try again.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/pages/common/login.jsp").forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/common/login.jsp").forward(req, res);
        }
    }
}