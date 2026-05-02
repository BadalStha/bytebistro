package com.bytebistro.menu.controller;

import com.bytebistro.menu.model.MenuItem;
import com.bytebistro.menu.model.dao.MenuDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("page");

        if ("list".equals(action)) {
            try {
                List<MenuItem> menuList = MenuDao.fetchMenuItems();
                req.setAttribute("menuItems", menuList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch menu items: " + e.getMessage());
            }
            req.getRequestDispatcher("pages/admin/menu-list.jsp").forward(req, resp);
        } else if ("add".equals(action)) {
            req.getRequestDispatcher("pages/admin/menu-form.jsp").forward(req, resp);
        } else if ("edit". equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                MenuItem menuItem = MenuDao.fetchMenuItemById(id);
                req.setAttribute("menuItem", menuItem);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch menu item: " + e.getMessage());
            }
            req.getRequestDispatcher("pages/admin/menu-form.jsp").forward(req, resp);
        } else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean result = MenuDao.deleteMenuItem(id);
                if (result) {
                    resp.sendRedirect("/admin/menu?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Unable to delete item");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }
        } else if ("search".equals(action)) {
            String keyword = req.getParameter("keyword");
            try {
                List<MenuItem> menuList = MenuDao.searchMenuItems(keyword);
                req.setAttribute("menuItems", menuList);
                req.setAttribute("keyword", keyword);
            } catch (Exception e) {
                req.setAttribute("error", "Search failed: " + e.getMessage());
            }
            req.getRequestDispatcher("pages/admin/menu-list.jsp").forward(req, resp);
        } else {
            try {
                List<MenuItem> menuList = MenuDao.fetchMenuItems();
                req.setAttribute("menuItems", menuList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch menu items: " + e.getMessage());
            }
            req.getRequestDispatcher("pages/admin/menu-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            String itemType = req.getParameter("itemType");
            boolean isAvailable = "true".equals(req.getParameter("isAvailable"));

            MenuItem item = new MenuItem();
            item.setName(name);
            item.setDescription(description);
            item.setPrice(price);
            item.setItemType(itemType);
            item.setAvailable(isAvailable);

            try {
                boolean result = MenuDao.insertMenuItem(item);
                if(result) {
                    resp.sendRedirect("/admin/menu?page=list");
                    return;
                } else {
                    req.setAttribute("error", "Failed to add item");
                }
            } catch (Exception e){
                req.setAttribute("error", e.getMessage());
            }
            req.getRequestDispatcher("pages/admin/menu-form.jsp").forward(req, resp);
        }
    }
}
