package com.bytebistro.menu.controller;

import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/edit-menu-item")
public class EditMenuItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int itemId = Integer.parseInt(req.getParameter("itemId"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String itemType = req.getParameter("itemType");
        boolean isAvailable = "true".equals(req.getParameter("isAvailable"));

        MenuItem item = new MenuItem();
        item.setItemId(itemId);
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setItemType(itemType);
        item.setAvailable(isAvailable);

        try {
            boolean result = MenuDao.updateMenuItem(item);
            if (result) {
                resp.sendRedirect("/admin/menu?page=list");
                return;
            } else {
                req.setAttribute("error", "Unable to update item");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
        }
        req.getRequestDispatcher("pages/admin/menu-form.jsp").forward(req, resp);
    }
}
