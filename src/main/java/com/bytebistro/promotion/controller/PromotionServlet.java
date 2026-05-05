package com.bytebistro.promotion.controller;

import com.bytebistro.promotion.model.Promotion;
import com.bytebistro.promotion.model.dao.PromotionDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/promotion")
public class PromotionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("page");

        if ("list".equals(action)) {
            try {
                List<Promotion> promotionList = PromotionDao.fetchPromotions();
                req.setAttribute("promotions", promotionList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch promotions: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);

        } else if ("add".equals(action)) {
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);

        } else if ("edit".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Promotion promotion = PromotionDao.fetchPromotionById(id);
                req.setAttribute("promotion", promotion);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch promotion: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);

        } else if ("deactivate".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean result = PromotionDao.deactivatePromotion(id);
                if (result) {
                    resp.sendRedirect(req.getContextPath() + "/admin/promotion?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Unable to deactivate promotion");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }

        } else if ("activate".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean result = PromotionDao.activatePromotion(id);
                if (result) {
                    resp.sendRedirect(req.getContextPath() + "/admin/promotion?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Unable to activate promotion");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }

        } else {
            try {
                List<Promotion> promotionList = PromotionDao.fetchPromotions();
                req.setAttribute("promotions", promotionList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch promotions: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            double discountPercent = Double.parseDouble(req.getParameter("discountPercent"));
            String validFrom = req.getParameter("validFrom");
            String validUntil = req.getParameter("validUntil");

            Promotion promotion = new Promotion();
            promotion.setTitle(title);
            promotion.setDescription(description);
            promotion.setDiscountPercent(discountPercent);
            promotion.setValidFrom(validFrom);
            promotion.setValidUntil(validUntil);
            promotion.setActive(true);

            try {
                boolean result = PromotionDao.insertPromotion(promotion);
                if (result) {
                    resp.sendRedirect(req.getContextPath() + "/admin/promotion?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Failed to add promotion");
                }
            } catch (Exception e) {
                req.setAttribute("error", e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);

        } else if ("edit".equals(action)) {
            int promotionId = Integer.parseInt(req.getParameter("promotionId"));
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            double discountPercent = Double.parseDouble(req.getParameter("discountPercent"));
            String validFrom = req.getParameter("validFrom");
            String validUntil = req.getParameter("validUntil");

            Promotion promotion = new Promotion();
            promotion.setPromotionId(promotionId);
            promotion.setTitle(title);
            promotion.setDescription(description);
            promotion.setDiscountPercent(discountPercent);
            promotion.setValidFrom(validFrom);
            promotion.setValidUntil(validUntil);
            promotion.setActive(true);

            try {
                boolean result = PromotionDao.updatePromotion(promotion);
                if (result) {
                    resp.sendRedirect(req.getContextPath() + "/admin/promotion?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Unable to update promotion");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/promotions.jsp").forward(req, resp);
        }
    }

}
