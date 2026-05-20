package com.bytebistro.menu.controller;

import com.bytebistro.image.model.Image;
import com.bytebistro.image.model.dao.ImageDao;
import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/menu")
public class PublicMenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // Fetch all menu items
            List<MenuItem> menuItems = MenuDao.fetchMenuItems();
            
            // Map to store image paths for each item
            Map<Integer, String> itemImages = new HashMap<>();
            
            for (MenuItem item : menuItems) {
                Image img = ImageDao.getImageByItemId(item.getItemId());
                if (img != null) {
                    itemImages.put(item.getItemId(), img.getImagePath());
                }
            }
            
            req.setAttribute("menuItems", menuItems);
            req.setAttribute("itemImages", itemImages);
            
            // Get unique categories for the tabs
            req.setAttribute("activeCategory", req.getParameter("category"));

        } catch (Exception e) {
            req.setAttribute("error", "Error loading menu: " + e.getMessage());
        }

        req.getRequestDispatcher("/pages/common/menu-view.jsp").forward(req, resp);
    }
}
