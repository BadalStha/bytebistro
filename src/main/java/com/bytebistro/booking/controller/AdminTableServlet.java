package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.booking.model.dao.TableInfoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/tables")
public class AdminTableServlet extends HttpServlet {

    private TableInfoDao tableDao = new TableInfoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("seed".equals(action)) {
            seedTables();
            resp.sendRedirect(req.getContextPath() + "/admin/tables?success=Default tables seeded!");
            return;
        }

        List<TableInfo> tables = tableDao.getAllTables();
        req.setAttribute("tables", tables);
        req.getRequestDispatcher("/pages/admin/table-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int tableNumber = Integer.parseInt(req.getParameter("tableNumber"));
            int capacity = Integer.parseInt(req.getParameter("capacity"));

            // Check if table number already exists
            boolean exists = tableDao.getAllTables().stream()
                    .anyMatch(t -> t.getTableNumber() == tableNumber);

            if (exists) {
                resp.sendRedirect(req.getContextPath() + "/admin/tables?error=Table number already exists!");
                return;
            }

            // Simple direct insert via DAO (I'll add this method to TableInfoDao)
            boolean success = tableDao.insertTable(tableNumber, capacity);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/tables?success=Table added!");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/tables?error=Failed to add table.");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/tables?error=" + e.getMessage());
        }
    }

    private void seedTables() {
        // Seed 8 tables if empty
        if (tableDao.getAllTables().isEmpty()) {
            tableDao.insertTable(1, 2);
            tableDao.insertTable(2, 2);
            tableDao.insertTable(3, 4);
            tableDao.insertTable(4, 4);
            tableDao.insertTable(5, 4);
            tableDao.insertTable(6, 6);
            tableDao.insertTable(7, 8);
            tableDao.insertTable(8, 2);
        }
    }
}
