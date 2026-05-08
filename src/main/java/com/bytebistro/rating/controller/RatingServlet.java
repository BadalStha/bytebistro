package com.bytebistro.rating.controller;

import com.bytebistro.rating.model.Rating;
import com.bytebistro.rating.model.dao.RatingDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/rating")
public class RatingServlet extends HttpServlet {

    // GET - display rating form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("userId");
            RatingDao dao = new RatingDao();

            // Check if user already rated
            // and load existing rating if so
            Rating existingRating = dao.getRatingByUserId(userId);
            if (existingRating != null) {
                req.setAttribute("existingRating", existingRating);
            }

            req.getRequestDispatcher("/pages/common/rating-form.jsp")
                    .forward(req, res);

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/pages/common/rating-form.jsp")
                    .forward(req, res);
        }
    }

    // POST - handle rating form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Get form fields
        String foodRatingStr    = req.getParameter("foodRating");
        String staffRatingStr   = req.getParameter("staffRating");
        String ambienceRatingStr = req.getParameter("ambienceRating");
        String comment          = req.getParameter("comment");

        // ── Validation ───────────────────────────────────────────

        // Check ratings are provided
        if (foodRatingStr == null || foodRatingStr.trim().isEmpty() ||
                staffRatingStr == null || staffRatingStr.trim().isEmpty() ||
                ambienceRatingStr == null ||
                ambienceRatingStr.trim().isEmpty()) {

            req.setAttribute("error",
                    "Please rate all three categories.");
            loadExistingRating(req, userId);
            req.getRequestDispatcher("/pages/common/rating-form.jsp")
                    .forward(req, res);
            return;
        }

        // Parse and validate rating values
        int foodRating, staffRating, ambienceRating;
        try {
            foodRating    = Integer.parseInt(foodRatingStr);
            staffRating   = Integer.parseInt(staffRatingStr);
            ambienceRating = Integer.parseInt(ambienceRatingStr);

            if (foodRating < 1 || foodRating > 5 ||
                    staffRating < 1 || staffRating > 5 ||
                    ambienceRating < 1 || ambienceRating > 5) {
                req.setAttribute("error",
                        "Ratings must be between 1 and 5.");
                loadExistingRating(req, userId);
                req.getRequestDispatcher("/pages/common/rating-form.jsp")
                        .forward(req, res);
                return;
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid rating values.");
            loadExistingRating(req, userId);
            req.getRequestDispatcher("/pages/common/rating-form.jsp")
                    .forward(req, res);
            return;
        }

        try {
            RatingDao dao = new RatingDao();

            // Build rating object
            Rating rating = new Rating();
            rating.setUserId(userId);
            rating.setFoodRating(foodRating);
            rating.setStaffRating(staffRating);
            rating.setAmbienceRating(ambienceRating);
            rating.setComment(comment != null ?
                    comment.trim() : "");

            // Check if user already rated
            // update if yes, save if no
            boolean success;
            if (dao.hasUserRated(userId)) {
                success = dao.updateRating(rating);
            } else {
                success = dao.saveRating(rating);
            }

            if (success) {
                res.sendRedirect(req.getContextPath() +
                        "/rating?success=Thank you for your feedback!");
            } else {
                req.setAttribute("error",
                        "Failed to submit rating. Please try again.");
                loadExistingRating(req, userId);
                req.getRequestDispatcher("/pages/common/rating-form.jsp")
                        .forward(req, res);
            }

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            loadExistingRating(req, userId);
            req.getRequestDispatcher("/pages/common/rating-form.jsp")
                    .forward(req, res);
        }
    }

    // Helper to load existing rating
    private void loadExistingRating(HttpServletRequest req,
                                    int userId) {
        try {
            RatingDao dao = new RatingDao();
            Rating existingRating = dao.getRatingByUserId(userId);
            if (existingRating != null) {
                req.setAttribute("existingRating", existingRating);
            }
        } catch (Exception e) {
            System.out.println("Error loading rating: " +
                    e.getMessage());
        }
    }
}