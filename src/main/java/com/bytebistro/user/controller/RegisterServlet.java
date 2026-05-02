package com.bytebistro.user.controller;

import com.bytebistro.user.model.User;
import com.bytebistro.user.model.dao.UserDao;
import com.bytebistro.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    // GET - display registration form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/common/register.jsp")
                .forward(request, response);
    }

    // POST - handle registration form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form fields
        String fullName = request.getParameter("fullName");
        String email    = request.getParameter("email");
        String phone    = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = "member";

        // ── Validation ──────────────────────────────────────────────

        // Check empty fields
        if (fullName == null || fullName.trim().isEmpty() ||
                email    == null || email.trim().isEmpty()    ||
                phone    == null || phone.trim().isEmpty()    ||
                password == null || password.trim().isEmpty() ||
                role     == null || role.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Full name must contain only letters and spaces
        if (!fullName.trim().matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Full name must contain only letters.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Email format validation
        if (!email.trim().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Invalid email format.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Phone must be numeric and 10-15 digits
        if (!phone.trim().matches("\\d{10,15}")) {
            request.setAttribute("error", "Phone must be 10-15 digits.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Password minimum 6 characters
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // Confirm password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── Duplicate checks ────────────────────────────────────────

        if (userDao.isEmailExists(email.trim())) {
            request.setAttribute("error", "Email already registered. Please use a different email.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        if (userDao.isPhoneExists(phone.trim())) {
            request.setAttribute("error", "Phone number already registered. Please use a different number.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
            return;
        }

        // ── Register user ───────────────────────────────────────────

        // Hash the password before storing
        String hashedPassword = PasswordUtil.hashPassword(password);

        // Build User object
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        user.setPasswordHash(hashedPassword);
        user.setRole(role);

        boolean success = userDao.registerUser(user);

        if (success) {
            // Redirect to login with success message
            response.sendRedirect(request.getContextPath() +
                    "/login?success=Registration successful! Please login.");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/pages/common/register.jsp")
                    .forward(request, response);
        }
    }
}