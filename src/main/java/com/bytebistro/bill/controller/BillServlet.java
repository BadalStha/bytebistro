package com.bytebistro.bill.controller;

import com.bytebistro.bill.model.Bill;
import com.bytebistro.bill.model.dao.BillDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/bill")
public class BillServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("page");

        if ("view".equals(action)) {
            try {
                int billId = Integer.parseInt(req.getParameter("id"));
                Bill bill = BillDao.fetchBillById(billId);
                req.setAttribute("bill", bill);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch bill: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/bill-view.jsp").forward(req, resp);

        } else {
            try {
                List<Bill> billList = BillDao.fetchBills();
                req.setAttribute("bills", billList);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch bills: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/bill-view.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("updatePayment".equals(action)) {
            int billId = Integer.parseInt(req.getParameter("billId"));
            String status = req.getParameter("status");

            try {
                boolean result = BillDao.updatePaymentStatus(billId, status);
                if (result) {
                    resp.sendRedirect("/admin/bill?page=view&id=" + billId);
                    return;
                } else {
                    req.setAttribute("error", "Unable to update payment status");
                }
            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/bill-view.jsp").forward(req, resp);
        }
    }

}
