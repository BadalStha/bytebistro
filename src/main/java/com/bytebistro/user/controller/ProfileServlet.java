package com.bytebistro.user.controller;

import com.bytebistro.user.model.User;
import com.bytebistro.user.model.dao.UserDao;
import com.bytebistro.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    // GET - display profile page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get session
        HttpSession session = req.getSession(false);

        // If no session redirect to login
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");

            // Fetch latest user data from DB
            UserDao dao = new UserDao();
            User user = dao.getUserById(userId);

            if (user == null) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // Set user object in request
            req.setAttribute("user", user);
            req.getRequestDispatcher("/pages/member/profile.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/member/profile.jsp")
                    .forward(req, res);
        }
    }

    // POST - handle profile update
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Get session
        HttpSession session = req.getSession(false);

        // If no session redirect to login
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = req.getParameter("action");

        try {
            UserDao dao = new UserDao();

            // ── Update Profile (name + phone) ────────────────────────
            if ("updateProfile".equals(action)) {

                String fullName = req.getParameter("fullName");
                String phone    = req.getParameter("phone");

                // Validate empty fields
                if (fullName == null || fullName.trim().isEmpty() ||
                        phone == null || phone.trim().isEmpty()) {
                    req.setAttribute("error", "Full name and phone are required.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Validate full name letters only
                if (!fullName.trim().matches("[a-zA-Z ]+")) {
                    req.setAttribute("error",
                            "Full name must contain only letters.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Validate phone digits only
                if (!phone.trim().matches("\\d{10,15}")) {
                    req.setAttribute("error",
                            "Phone must be 10-15 digits only.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Check if phone already exists for another user
                if (dao.isPhoneExistsForOtherUser(phone.trim(), userId)) {
                    req.setAttribute("error",
                            "Phone number already in use by another account.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Update profile in DB
                boolean updated = dao.updateProfile(
                        userId, fullName.trim(), phone.trim());

                if (updated) {
                    // Update session with new name
                    session.setAttribute("fullName", fullName.trim());
                    res.sendRedirect(req.getContextPath() +
                            "/profile?success=Profile updated successfully.");
                } else {
                    req.setAttribute("error",
                            "Failed to update profile. Please try again.");
                    loadUserAndForward(req, res, userId, dao);
                }

                // ── Change Password ──────────────────────────────────────
            } else if ("changePassword".equals(action)) {

                String currentPassword = req.getParameter("currentPassword");
                String newPassword     = req.getParameter("newPassword");
                String confirmPassword = req.getParameter("confirmPassword");

                // Validate empty fields
                if (currentPassword == null || currentPassword.trim().isEmpty() ||
                        newPassword == null || newPassword.trim().isEmpty() ||
                        confirmPassword == null || confirmPassword.trim().isEmpty()) {
                    req.setAttribute("error",
                            "All password fields are required.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Validate new password length
                if (newPassword.length() < 6) {
                    req.setAttribute("error",
                            "New password must be at least 6 characters.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Validate passwords match
                if (!newPassword.equals(confirmPassword)) {
                    req.setAttribute("error",
                            "New passwords do not match.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Verify current password
                User user = dao.getUserById(userId);
                if (!PasswordUtil.verifyPassword(
                        currentPassword, user.getPasswordHash())) {
                    req.setAttribute("error",
                            "Current password is incorrect.");
                    loadUserAndForward(req, res, userId, dao);
                    return;
                }

                // Update password in DB
                boolean updated = dao.updatePassword(userId, newPassword);

                if (updated) {
                    res.sendRedirect(req.getContextPath() +
                            "/profile?success=Password changed successfully.");
                } else {
                    req.setAttribute("error",
                            "Failed to change password. Please try again.");
                    loadUserAndForward(req, res, userId, dao);
                }

            } else {
                res.sendRedirect(req.getContextPath() + "/profile");
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadUserAndForward(req, res, userId, dao);
        }
    }

    // Helper method to load user and forward to profile page
    private void loadUserAndForward(HttpServletRequest req,
                                    HttpServletResponse res, int userId, UserDao dao)
            throws ServletException, IOException {
        try {
            User user = dao.getUserById(userId);
            req.setAttribute("user", user);
        } catch (Exception e) {
            System.out.println("Error loading user: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/member/profile.jsp")
                .forward(req, res);
    }

    // Dummy declaration to avoid compile error
    // (dao is declared inside try block above)
    private UserDao dao = null;
}