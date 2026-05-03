package com.bytebistro.booking.controller;

import com.bytebistro.booking.model.TableInfo;
import com.bytebistro.booking.model.dao.TableInfoDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/table")
public class TableServlet extends HttpServlet {

    // GET - fetch available tables for selected date and time
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String bookingDate = req.getParameter("bookingDate");
        String bookingTime = req.getParameter("bookingTime");

        // Set response type to JSON
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        PrintWriter out = res.getWriter();

        // Validate parameters
        if (bookingDate == null || bookingDate.trim().isEmpty() ||
                bookingTime == null || bookingTime.trim().isEmpty()) {
            out.print("{\"error\": \"Date and time are required.\"}");
            out.flush();
            return;
        }

        try {
            TableInfoDao tableInfoDao = new TableInfoDao();
            List<TableInfo> availableTables = tableInfoDao
                    .getAvailableTables(bookingDate, bookingTime);

            // Build JSON response manually
            StringBuilder json = new StringBuilder();
            json.append("[");

            for (int i = 0; i < availableTables.size(); i++) {
                TableInfo table = availableTables.get(i);
                json.append("{");
                json.append("\"tableId\": ").append(table.getTableId()).append(", ");
                json.append("\"tableNumber\": ").append(table.getTableNumber()).append(", ");
                json.append("\"seatingCapacity\": ").append(table.getSeatingCapacity());
                json.append("}");

                // Add comma between items but not after last item
                if (i < availableTables.size() - 1) {
                    json.append(", ");
                }
            }

            json.append("]");
            out.print(json.toString());

        } catch (Exception e) {
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        }

        out.flush();
    }
}