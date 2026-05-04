package com.bytebistro.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        // Cast to HTTP specific classes
        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        try {
            // Get existing session without creating a new one
            HttpSession session = req.getSession(false);

            // Check if user is logged in
            if (session != null && session.getAttribute("userId") != null) {

                // Check if user has admin role
                String role = (String) session.getAttribute("role");

                if ("admin".equals(role)) {
                    // User is admin, allow request to proceed
                    chain.doFilter(request, response);
                } else {
                    // User is logged in but not admin
                    res.sendRedirect(req.getContextPath() +
                            "/login?error=You are not authorized to access this page.");
                }

            } else {
                // User is not logged in, redirect to login page
                res.sendRedirect(req.getContextPath() +
                        "/login?error=Please login to access this page.");
            }

        } catch (Exception e) {
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}