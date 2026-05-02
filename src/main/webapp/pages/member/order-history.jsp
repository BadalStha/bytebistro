<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.order.model.Order" %>
<%@ page import="com.bytebistro.order.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - ByteBistro</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f5f5dc;
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
        }

        /* ── Navbar ── */
        .navbar {
            background: #fff;
            padding: 14px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #8B0000;
            font-style: italic;
            text-decoration: none;
        }

        .navbar-links {
            display: flex;
            gap: 32px;
            list-style: none;
        }

        .navbar-links a {
            text-decoration: none;
            color: #444;
            font-size: 14px;
            transition: color 0.2s;
        }

        .navbar-links a.active,
        .navbar-links a:hover {
            color: #8B0000;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 2px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .btn-new-booking {
            background: #8B0000;
            color: #fff;
            padding: 8px 18px;
            border-radius: 3px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
            text-decoration: none;
            text-transform: uppercase;
            transition: background 0.2s;
        }

        .btn-new-booking:hover {
            background: #6b0000;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #8B0000;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 600;
        }

        /* ── Page Container ── */
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 48px 24px;
        }

        /* ── Page Header ── */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .header-left h1 {
            font-family: 'Georgia', serif;
            font-size: 48px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 10px;
        }

        .header-left p {
            font-size: 14px;
            color: #666;
            max-width: 480px;
            line-height: 1.6;
        }

        .header-right {
            text-align: right;
        }

        .member-since-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B0000;
            margin-bottom: 4px;
        }

        .member-since-date {
            font-family: 'Georgia', serif;
            font-size: 28px;
            font-style: italic;
            color: #1a1a1a;
        }

        /* ── Stats Cards ── */
        .stats-row {
            display: flex;
            gap: 16px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: #fff;
            border-radius: 6px;
            padding: 24px 32px;
            min-width: 200px;
        }

        .stat-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 8px;
        }

        .stat-value {
            font-family: 'Georgia', serif;
            font-size: 36px;
            font-weight: 700;
            color: #1a1a1a;
        }

        /* ── Signature Banner ── */
        .signature-banner {
            flex: 1;
            background: #3a1a1a;
            border-radius: 6px;
            padding: 24px 32px;
            min-width: 260px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-image: linear-gradient(
                    135deg,
                    rgba(58,26,26,0.95) 0%,
                    rgba(100,30,30,0.85) 100%
            );
        }

        .signature-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #c8a96e;
            margin-bottom: 8px;
        }

        .signature-title {
            font-family: 'Georgia', serif;
            font-size: 24px;
            font-style: italic;
            color: #fff;
            margin-bottom: 16px;
        }

        .btn-explore {
            display: inline-block;
            background: none;
            border: 1px solid #c8a96e;
            color: #c8a96e;
            padding: 8px 16px;
            border-radius: 3px;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            text-decoration: none;
            transition: all 0.2s;
            width: fit-content;
        }

        .btn-explore:hover {
            background: #c8a96e;
            color: #3a1a1a;
        }

        /* ── Orders Table ── */
        .orders-table-wrapper {
            background: #fff;
            border-radius: 6px;
            overflow: hidden;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table thead tr {
            border-bottom: 1px solid #f0f0f0;
        }

        .orders-table thead th {
            padding: 16px 20px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            font-weight: 600;
        }

        .orders-table tbody tr {
            border-bottom: 1px solid #f9f9f9;
            transition: background 0.15s;
        }

        .orders-table tbody tr:hover {
            background: #fafaf7;
        }

        .orders-table tbody tr:last-child {
            border-bottom: none;
        }

        .orders-table td {
            padding: 20px;
            font-size: 14px;
            color: #333;
            vertical-align: middle;
        }

        .order-id {
            font-family: 'Georgia', serif;
            font-weight: 700;
            color: #1a1a1a;
            font-size: 15px;
        }

        .order-date {
            color: #666;
            font-size: 13px;
        }

        .items-summary {
            color: #444;
            font-size: 13px;
            max-width: 260px;
        }

        .order-amount {
            font-weight: 700;
            color: #1a1a1a;
            font-size: 15px;
        }

        /* ── Status Badges ── */
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-delivered {
            background: #fff3cd;
            color: #856404;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .status-processing {
            background: #e8e8e8;
            color: #555;
        }

        /* ── View Bill Link ── */
        .view-bill-link {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #1a1a1a;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            white-space: nowrap;
            transition: color 0.2s;
        }

        .view-bill-link:hover {
            color: #8B0000;
        }

        /* ── Cancel Form ── */
        .btn-cancel {
            background: none;
            border: none;
            color: #8B0000;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            padding: 0;
            font-family: 'Arial', sans-serif;
            transition: color 0.2s;
        }

        .btn-cancel:hover {
            color: #6b0000;
            text-decoration: underline;
        }

        /* ── Table Footer ── */
        .table-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 20px;
            border-top: 1px solid #f0f0f0;
            background: #fff;
            flex-wrap: wrap;
            gap: 12px;
        }

        .showing-text {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
        }

        .pagination {
            display: flex;
            gap: 8px;
        }

        .page-btn {
            width: 32px;
            height: 32px;
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .page-btn:hover {
            background: #8B0000;
            color: #fff;
            border-color: #8B0000;
        }

        /* ── Empty State ── */
        .empty-state {
            text-align: center;
            padding: 60px 24px;
            background: #fff;
            border-radius: 6px;
        }

        .empty-state h3 {
            font-family: 'Georgia', serif;
            font-size: 24px;
            color: #1a1a1a;
            margin-bottom: 12px;
        }

        .empty-state p {
            font-size: 14px;
            color: #888;
            margin-bottom: 24px;
        }

        .btn-primary {
            display: inline-block;
            background: #8B0000;
            color: #fff;
            padding: 12px 24px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            text-decoration: none;
            transition: background 0.2s;
        }

        .btn-primary:hover {
            background: #6b0000;
        }

        /* ── Alerts ── */
        .alert {
            padding: 10px 14px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #fdf0f0;
            color: #8B0000;
            border-left: 3px solid #8B0000;
        }

        .alert-success {
            background: #f0fdf4;
            color: #166534;
            border-left: 3px solid #166534;
        }

        /* ── Footer ── */
        .page-footer {
            background: #fff;
            padding: 32px 40px;
            margin-top: 60px;
            border-top: 1px solid #eee;
        }

        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
        }

        .footer-brand {
            font-family: 'Georgia', serif;
            font-size: 13px;
            color: #666;
        }

        .footer-links {
            display: flex;
            gap: 24px;
            list-style: none;
        }

        .footer-links a {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: #8B0000;
        }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .header-left h1 { font-size: 32px; }
            .stats-row { flex-direction: column; }
            .orders-table thead { display: none; }
            .orders-table td {
                display: block;
                padding: 8px 16px;
            }
            .orders-table td:first-child {
                padding-top: 16px;
            }
            .orders-table td:last-child {
                padding-bottom: 16px;
            }
        }
    </style>
</head>
<body>

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";

    // Get member since date from createdAt
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    int totalOrders = (orders != null) ? orders.size() : 0;
    int loyaltyPoints = totalOrders * 50; // 50 points per order
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
        ByteBistro
    </a>
    <ul class="navbar-links">
        <li>
            <a href="${pageContext.request.contextPath}/booking">
                Reservations
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">
                Menu
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order?action=history"
               class="active">Orders</a>
        </li>
    </ul>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/booking"
           class="btn-new-booking">New Booking</a>
        <div class="user-avatar"><%= initial %></div>
    </div>
</nav>

<div class="container">

    <%-- Alerts --%>
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getParameter("success") %>
    </div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getParameter("error") %>
    </div>
    <% } %>

    <!-- Page Header -->
    <div class="page-header">
        <div class="header-left">
            <h1>My Orders</h1>
            <p>A curated archive of your gastronomic journeys with us.
                Review past selections or re-order your favourite items.</p>
        </div>
        <div class="header-right">
            <p class="member-since-label">Member Since</p>
            <p class="member-since-date">ByteBistro</p>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="stats-row">
        <div class="stat-card">
            <p class="stat-label">Total Orders</p>
            <p class="stat-value"><%= totalOrders %></p>
        </div>
        <div class="stat-card">
            <p class="stat-label">Loyalty Points</p>
            <p class="stat-value"><%= loyaltyPoints %></p>
        </div>
        <div class="signature-banner">
            <div>
                <p class="signature-label">Signature Recommendation</p>
                <p class="signature-title">The Autumn Degustation</p>
            </div>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp"
               class="btn-explore">Explore Menu</a>
        </div>
    </div>

    <!-- Orders Table -->
    <% if (orders != null && !orders.isEmpty()) { %>

    <div class="orders-table-wrapper">
        <table class="orders-table">
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Items Summary</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Order order : orders) {
                // Build items summary string
                List<OrderItem> items = order.getOrderItems();
                StringBuilder summary = new StringBuilder();
                if (items != null && !items.isEmpty()) {
                    for (int i = 0; i < Math.min(items.size(), 3); i++) {
                        if (i > 0) summary.append(", ");
                        summary.append(items.get(i).getItemName());
                    }
                    if (items.size() > 3) summary.append("...");
                } else {
                    summary.append("—");
                }
            %>
            <tr>
                <td>
                                <span class="order-id">
                                    #BB-<%= order.getOrderId() %>
                                </span>
                </td>
                <td>
                                <span class="order-date">
                                    <%= order.getOrderedAt() %>
                                </span>
                </td>
                <td>
                                <span class="items-summary">
                                    <%= summary.toString() %>
                                </span>
                </td>
                <td>
                                <span class="order-amount">
                                    Rs. <%= String.format("%.2f",
                                        order.getTotalAmount()) %>
                                </span>
                </td>
                <td>
                                <span class="status-badge status-<%= order.getStatus() %>">
                                    <%= order.getStatus().toUpperCase() %>
                                </span>
                </td>
                <td>
                    <% if ("pending".equals(order.getStatus())) { %>
                    <form action="${pageContext.request.contextPath}/order"
                          method="post" style="display:inline;">
                        <input type="hidden" name="action"
                               value="cancel"/>
                        <input type="hidden" name="orderId"
                               value="<%= order.getOrderId() %>"/>
                        <button type="submit" class="btn-cancel"
                                onclick="return confirm(
                                                    'Cancel this order?')">
                            Cancel &#x2715;
                        </button>
                    </form>
                    <% } else { %>
                    <a href="${pageContext.request.contextPath}/bill?orderId=<%= order.getOrderId() %>"
                       class="view-bill-link">
                        View Bill &#8594;
                    </a>
                    <% } %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <!-- Table Footer -->
        <div class="table-footer">
                    <span class="showing-text">
                        Showing <%= orders.size() %> of
                        <%= orders.size() %> Entries
                    </span>
            <div class="pagination">
                <button class="page-btn">&#8249;</button>
                <button class="page-btn">&#8250;</button>
            </div>
        </div>
    </div>

    <% } else { %>

    <!-- Empty State -->
    <div class="empty-state">
        <h3>No orders yet</h3>
        <p>You have not placed any orders yet.
            Start your gastronomic journey today.</p>
        <a href="${pageContext.request.contextPath}/order"
           class="btn-primary">Place Your First Order</a>
    </div>

    <% } %>

</div>

<!-- Footer -->
<footer class="page-footer">
    <div class="footer-bottom">
        <p class="footer-brand">
            &copy; 2024 ByteBistro Editorial. All Rights Reserved.
        </p>
        <ul class="footer-links">
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Terms of Service</a></li>
            <li><a href="#">Contact Ma&icirc;tre D&apos;</a></li>
        </ul>
    </div>
</footer>

</body>
</html>