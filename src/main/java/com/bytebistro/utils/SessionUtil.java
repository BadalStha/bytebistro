package com.bytebistro.utils;

import com.bytebistro.user.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    // Method to create session after successful login
    public static void createSession(HttpServletRequest request, User user) {
        // Invalidate any existing session first for security
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Create a new session
        HttpSession newSession = request.getSession(true);

        // Store user details in session
        newSession.setAttribute("userId", user.getUserId());
        newSession.setAttribute("fullName", user.getFullName());
        newSession.setAttribute("email", user.getEmail());
        newSession.setAttribute("role", user.getRole());

        // Session expires after 30 minutes of inactivity
        newSession.setMaxInactiveInterval(30 * 60);
    }

    // Method to get current logged-in user's ID from session
    public static int getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            return (int) session.getAttribute("userId");
        }
        return -1; // Return -1 if no session found
    }

    // Method to get current logged-in user's role from session
    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            return (String) session.getAttribute("role");
        }
        return null;
    }

    // Method to get current logged-in user's full name from session
    public static String getFullName(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("fullName") != null) {
            return (String) session.getAttribute("fullName");
        }
        return null;
    }

    // Method to check if user is logged in
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("userId") != null;
    }

    // Method to check if logged-in user is a member
    public static boolean isMember(HttpServletRequest request) {
        String role = getUserRole(request);
        return "member".equals(role);
    }

    // Method to check if logged-in user is an admin
    public static boolean isAdmin(HttpServletRequest request) {
        String role = getUserRole(request);
        return "admin".equals(role);
    }

    // Method to destroy session on logout
    public static void destroySession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}