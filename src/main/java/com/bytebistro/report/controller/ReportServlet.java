package com.bytebistro.report.controller;

import com.bytebistro.bill.model.Bill;
import com.bytebistro.bill.model.dao.BillDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/report"})
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String fromDate = req.getParameter("fromDate");
            String toDate = req.getParameter("toDate");

            double totalRevenue = 0;
            double totalDiscount = 0;
            List<Bill> bills = null;
            int billCount = 0;
            double averageOrderValue = 0;

            if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
                bills = BillDao.fetchBillsByDateRange(fromDate, toDate);
            } else {
                bills = BillDao.fetchBills();
            }

            for (Bill b : bills) {
                totalRevenue += b.getFinalAmount();
                totalDiscount += b.getDiscount();
            }
            billCount = bills.size();

            if (billCount > 0) {
                averageOrderValue = totalRevenue / billCount;
            }

            req.setAttribute("bills", bills);
            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("totalDiscount", totalDiscount);
            req.setAttribute("billCount", billCount);
            req.setAttribute("averageOrderValue", averageOrderValue);
            req.setAttribute("fromDate", fromDate);
            req.setAttribute("toDate", toDate);

        } catch (Exception e) {
            req.setAttribute("error", "Unable to fetch financial report: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/admin/financial-report.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");

        try {
            if (fromDate == null || toDate == null || fromDate.isEmpty() || toDate.isEmpty()) {
                req.setAttribute("error", "Please select both From and To dates");
                req.getRequestDispatcher("/pages/admin/financial-report.jsp").forward(req, resp);
                return;
            }

            List<Bill> bills = BillDao.fetchBillsByDateRange(fromDate, toDate);
            double totalRevenue = 0;
            double totalDiscount = 0;
            int billCount = bills.size();
            double averageOrderValue = 0;

            for (Bill b : bills) {
                totalRevenue += b.getFinalAmount();
                totalDiscount += b.getDiscount();
            }

            if (billCount > 0) {
                averageOrderValue = totalRevenue / billCount;
            }

            req.setAttribute("bills", bills);
            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("totalDiscount", totalDiscount);
            req.setAttribute("billCount", billCount);
            req.setAttribute("averageOrderValue", averageOrderValue);
            req.setAttribute("fromDate", fromDate);
            req.setAttribute("toDate", toDate);

        } catch (Exception e) {
            req.setAttribute("error", "Something went wrong: " + e.getMessage());
        }
        req.getRequestDispatcher("/pages/admin/financial-report.jsp").forward(req, resp);
    }
}
