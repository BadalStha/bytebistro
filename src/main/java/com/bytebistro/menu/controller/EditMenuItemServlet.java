package com.bytebistro.menu.controller;

import com.bytebistro.image.model.Image;
import com.bytebistro.image.model.dao.ImageDao;
import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;
import com.bytebistro.utils.ImageUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

// @WebServlet("/admin/edit-menu-item")
@MultipartConfig
public class EditMenuItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int itemId = Integer.parseInt(req.getParameter("itemId"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String itemType = req.getParameter("itemType");
        boolean isAvailable = "true".equals(req.getParameter("isAvailable"));
        Part imagePart = req.getPart("itemImage");

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
                // If new image uploaded, save it
                if (imagePart != null && imagePart.getSize() > 0) {
                    String imagePath = ImageUtils.saveImageInDirectory(imagePart);
                    boolean imageResult = ImageDao.insertImageDetails(String.valueOf(itemId), imagePath);
                }

                resp.sendRedirect("/admin/menu?page=list");
                return;
            } else {
                req.setAttribute("error", "Unable to update item");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/admin/menu-form.jsp").forward(req, resp);
    }

}
