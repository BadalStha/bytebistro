package com.bytebistro.report.controller;

import com.bytebistro.bill.model.Bill;
import com.bytebistro.bill.model.dao.BillDao;
import com.bytebistro.order.model.Order;
import com.bytebistro.order.model.OrderItem;
import com.bytebistro.order.model.dao.OrderDao;
import com.bytebistro.order.model.dao.OrderItemDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("page");

        if ("financial".equals(action)) {
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
                    for (Bill b : bills) {
                        totalRevenue += b.getFinalAmount();
                        totalDiscount += b.getDiscount();
                    }
                    billCount = bills.size();

                    if (billCount > 0) {
                        averageOrderValue = totalRevenue / billCount;
                    }
                } else {
                    bills = BillDao.fetchBills();
                    for (Bill b : bills) {
                        totalRevenue += b.getFinalAmount();
                        totalDiscount += b.getDiscount();
                    }
                    billCount = bills.size();

                    if (billCount > 0) {
                        averageOrderValue = totalRevenue / billCount;
                    }
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

        } else if ("analytics".equals(action)) {
            try {
                double totalRevenue = BillDao.fetchTotalRevenue();
                List<Bill> allBills = BillDao.fetchBills();

                double averageOrderValue = 0;
                double monthlyRevenue = 0;
                double predictedNextMonth = 0;

                if (allBills.size() > 0) {
                    averageOrderValue = totalRevenue / allBills.size();
                }

                // Calculate current month revenue
                LocalDate today = LocalDate.now();
                String monthStart = today.getYear() + "-" + String.format("%02d", today.getMonthValue()) + "-01";
                String monthEnd = today.toString();

                try {
                    List<Bill> monthBills = BillDao.fetchBillsByDateRange(monthStart, monthEnd);
                    for (Bill b : monthBills) {
                        monthlyRevenue += b.getFinalAmount();
                    }
                } catch (Exception e) {
                    monthlyRevenue = totalRevenue / 12;
                }

                // Predict next month (simple: same as current month)
                predictedNextMonth = monthlyRevenue;

                // Get top selling items
                Map<Integer, Integer> itemOrderCount = new HashMap<>();
                try {
                    List<Order> allOrders = OrderDao.fetchOrders();
                    for (Order o : allOrders) {
                        List<OrderItem> items = OrderItemDao.fetchOrderItems(o.getOrderId());
                        for (OrderItem item : items) {
                            itemOrderCount.put(item.getItemId(),
                                    itemOrderCount.getOrDefault(item.getItemId(), 0) + item.getQuantity());
                        }
                    }
                } catch (Exception e) {
                    // Continue with empty data
                }

                req.setAttribute("totalRevenue", totalRevenue);
                req.setAttribute("totalOrders", allBills.size());
                req.setAttribute("averageOrderValue", averageOrderValue);
                req.setAttribute("monthlyRevenue", monthlyRevenue);
                req.setAttribute("predictedNextMonth", predictedNextMonth);
                req.setAttribute("itemOrderCount", itemOrderCount);

            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch analytics: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/analytics.jsp").forward(req, resp);

        } else {
            try {
                double totalRevenue = BillDao.fetchTotalRevenue();
                List<Bill> bills = BillDao.fetchBills();
                int billCount = bills.size();
                double averageOrderValue = 0;

                if (billCount > 0) {
                    averageOrderValue = totalRevenue / billCount;
                }

                req.setAttribute("totalRevenue", totalRevenue);
                req.setAttribute("bills", bills);
                req.setAttribute("billCount", billCount);
                req.setAttribute("averageOrderValue", averageOrderValue);
            } catch (Exception e) {
                req.setAttribute("error", "Unable to fetch report: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/financial-report.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("filterByDate".equals(action)) {
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

        } else if ("filterAnalytics".equals(action)) {
            String fromDate = req.getParameter("fromDate");
            String toDate = req.getParameter("toDate");

            try {
                if (fromDate == null || toDate == null || fromDate.isEmpty() || toDate.isEmpty()) {
                    req.setAttribute("error", "Please select both From and To dates");
                    req.getRequestDispatcher("/pages/admin/analytics.jsp").forward(req, resp);
                    return;
                }

                List<Bill> periodBills = BillDao.fetchBillsByDateRange(fromDate, toDate);
                double periodRevenue = 0;

                for (Bill b : periodBills) {
                    periodRevenue += b.getFinalAmount();
                }

                double totalRevenue = BillDao.fetchTotalRevenue();
                List<Bill> allBills = BillDao.fetchBills();
                double averageOrderValue = 0;

                if (allBills.size() > 0) {
                    averageOrderValue = totalRevenue / allBills.size();
                }

                req.setAttribute("totalRevenue", periodRevenue);
                req.setAttribute("totalOrders", periodBills.size());
                req.setAttribute("averageOrderValue", averageOrderValue);
                req.setAttribute("fromDate", fromDate);
                req.setAttribute("toDate", toDate);

            } catch (Exception e) {
                req.setAttribute("error", "Something went wrong: " + e.getMessage());
            }
            req.getRequestDispatcher("/pages/admin/analytics.jsp").forward(req, resp);
        }
    }

}
