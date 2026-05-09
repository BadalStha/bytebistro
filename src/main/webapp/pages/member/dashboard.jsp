<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ page import="com.bytebistro.booking.model.dao.BookingDao" %>
<%@ page import="com.bytebistro.user.model.User" %>
<%@ page import="com.bytebistro.user.model.dao.UserDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - ByteBistro</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

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
            color: #1a1a1a;
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

        .navbar-links a:hover {
            color: #8B0000;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-signin {
            background: none;
            border: none;
            font-size: 13px;
            color: #444;
            cursor: pointer;
            letter-spacing: 1px;
            text-decoration: none;
            font-family: 'Arial', sans-serif;
            transition: color 0.2s;
        }

        .btn-signin:hover { color: #8B0000; }

        .btn-join {
            background: #8B0000;
            color: #fff;
            padding: 10px 20px;
            border-radius: 3px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
            text-decoration: none;
            text-transform: uppercase;
            transition: background 0.2s;
        }

        .btn-join:hover { background: #6b0000; }

        /* ── Page Container ── */
        .container {
            max-width: 1060px;
            margin: 0 auto;
            padding: 32px 24px 80px;
        }

        /* ── Hero Section ── */
        .hero-card {
            background: #eeeec8;
            border-radius: 8px;
            padding: 48px;
            display: flex;
            justify-content: space-between;
            align-items: stretch;
            margin-bottom: 24px;
            overflow: hidden;
            position: relative;
            min-height: 260px;
        }

        .hero-left {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .hero-label {
            font-size: 10px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: #8B0000;
            margin-bottom: 16px;
        }

        .hero-title {
            font-family: 'Georgia', serif;
            font-size: 48px;
            font-weight: 700;
            color: #1a1a1a;
            line-height: 1.15;
            margin-bottom: 20px;
        }

        .hero-title span {
            font-style: italic;
        }

        .hero-desc {
            font-size: 14px;
            color: #555;
            line-height: 1.7;
            max-width: 380px;
        }

        .hero-image {
            width: 320px;
            flex-shrink: 0;
            border-radius: 6px;
            background: linear-gradient(
                    135deg,
                    rgba(200,169,110,0.3) 0%,
                    rgba(139,0,0,0.15) 100%
            ),
            url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600')
            center/cover;
            margin-left: 32px;
        }

        /* ── Stats Row ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: #fff;
            border-radius: 8px;
            padding: 28px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .stat-card-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .stat-icon { font-size: 20px; color: #8B0000; }

        .stat-badge {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #aaa;
        }

        .stat-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
        }

        .stat-value {
            font-family: 'Georgia', serif;
            font-size: 48px;
            font-weight: 700;
            color: #1a1a1a;
            line-height: 1;
            margin: 4px 0;
        }

        .stat-value.amount {
            font-size: 36px;
            color: #1a1a1a;
        }

        .stat-link {
            font-size: 12px;
            color: #555;
            text-decoration: none;
            transition: color 0.2s;
            margin-top: 4px;
        }

        .stat-link:hover { color: #8B0000; }

        .stat-note {
            font-size: 12px;
            color: #888;
            font-style: italic;
            margin-top: 4px;
        }

        /* ── Tables Section ── */
        .tables-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .section-title {
            font-family: 'Georgia', serif;
            font-size: 24px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .section-link {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B0000;
            text-decoration: none;
            transition: color 0.2s;
        }

        .section-link:hover { color: #6b0000; }

        /* ── Data Table ── */
        .data-table-wrapper {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead tr {
            border-bottom: 1px solid #f0f0f0;
        }

        .data-table thead th {
            padding: 12px 16px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #aaa;
            font-weight: 600;
        }

        .data-table tbody tr {
            border-bottom: 1px solid #f9f9f9;
            transition: background 0.15s;
        }

        .data-table tbody tr:hover {
            background: #fafaf7;
        }

        .data-table tbody tr:last-child {
            border-bottom: none;
        }

        .data-table td {
            padding: 16px;
            font-size: 13px;
            color: #333;
            vertical-align: middle;
        }

        .table-id {
            font-family: 'Georgia', serif;
            font-weight: 700;
            color: #1a1a1a;
            font-size: 13px;
        }

        .table-date {
            font-weight: 600;
            color: #1a1a1a;
            font-size: 13px;
        }

        .table-time {
            font-size: 11px;
            color: #888;
            margin-top: 2px;
        }

        .table-details {
            font-size: 12px;
            color: #555;
        }

        .table-detail-icon {
            font-size: 11px;
            margin-right: 4px;
        }

        .table-guests {
            font-size: 11px;
            color: #888;
            margin-top: 2px;
        }

        .table-amount {
            font-weight: 700;
            color: #1a1a1a;
            font-size: 14px;
        }

        .table-items {
            font-size: 12px;
            color: #333;
            max-width: 160px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .table-item-date {
            font-size: 11px;
            color: #888;
            margin-top: 2px;
        }

        /* ── Status Badges ── */
        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 3px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-confirmed {
            background: #d1e7dd;
            color: #0f5132;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .status-completed {
            background: #e8e8e8;
            color: #555;
        }

        .status-delivered {
            background: #d1e7dd;
            color: #0f5132;
        }

        .status-processing {
            background: #e8e8e8;
            color: #555;
        }

        /* ── Empty State ── */
        .empty-row td {
            text-align: center;
            padding: 32px;
            font-style: italic;
            color: #aaa;
            font-size: 13px;
        }

        /* ── Footer ── */
        .page-footer {
            background: #f5f5dc;
            padding: 40px;
            margin-top: 60px;
            border-top: 1px solid #e0dfc8;
        }

        .footer-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
        }

        .footer-brand {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-style: italic;
            font-weight: 700;
            color: #1a1a1a;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .footer-links {
            display: flex;
            gap: 32px;
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

        .footer-links a:hover { color: #8B0000; }

        .footer-copy {
            font-size: 11px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #aaa;
        }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .hero-image { display: none; }
            .stats-row { grid-template-columns: 1fr; }
            .tables-row { grid-template-columns: 1fr; }
            .hero-title { font-size: 32px; }
        }

        @media (max-width: 560px) {
            .navbar-links { display: none; }
            .hero-card { padding: 28px; }
        }
    </style>
</head>
<body>

<%
    // Get session data
    String fullName = (String) session.getAttribute("fullName");
    int userId = (int) session.getAttribute("userId");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";

    // Split full name for italic styling
    String[] nameParts = fullName != null ?
            fullName.split(" ", 2) : new String[]{"Member", ""};
    String firstName = nameParts[0];
    String lastName  = nameParts.length > 1 ? nameParts[1] : "";

    // Fetch user data
    UserDao userDao = new UserDao();
    User user = userDao.getUserById(userId);
    String memberSince = (user != null && user.getCreatedAt() != null)
            ? user.getCreatedAt().toString().substring(0, 7) : "N/A";

    // Fetch booking data
    BookingDao bookingDao = new BookingDao();
    List<Booking> bookings = bookingDao.getBookingsByUserId(userId);
    int totalBookings = bookingDao.getTotalBookingsByUserId(userId);

    // Count active bookings
    int activeBookings = 0;
    if (bookings != null) {
        for (Booking b : bookings) {
            if ("pending".equals(b.getStatus()) ||
                    "confirmed".equals(b.getStatus())) {
                activeBookings++;
            }
        }
    }

    // Get recent bookings (last 3)
    List<Booking> recentBookings = new java.util.ArrayList<>();
    if (bookings != null) {
        for (int i = 0; i < Math.min(3, bookings.size()); i++) {
            recentBookings.add(bookings.get(i));
        }
    }
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/pages/member/dashboard.jsp"
       class="navbar-brand">ByteBistro</a>
    <ul class="navbar-links">
        <li>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">
                Menu</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/booking">
                Reservations</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order">
                Orders</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/rating">
                Feedback</a>
        </li>
    </ul>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/profile"
           class="btn-signin">My Profile</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="btn-join">Sign Out</a>
    </div>
</nav>

<!-- Page Container -->
<div class="container">

    <!-- Hero Section -->
    <div class="hero-card">
        <div class="hero-left">
            <p class="hero-label">Member Exclusive Dashboard</p>
            <h1 class="hero-title">
                Welcome back,<br>
                <span><%= firstName %> <%= lastName %></span>
            </h1>
            <p class="hero-desc">
                Your table is always waiting. Review your
                upcoming reservations and culinary
                preferences below.
            </p>
        </div>
        <div class="hero-image"></div>
    </div>

    <!-- Stats Row -->
    <div class="stats-row">

        <!-- Active Bookings -->
        <div class="stat-card">
            <div class="stat-card-top">
                <span class="stat-icon">&#128197;</span>
                <span class="stat-badge">Live</span>
            </div>
            <span class="stat-label">Active Bookings</span>
            <p class="stat-value">
                <%= String.format("%02d", activeBookings) %>
            </p>
            <a href="${pageContext.request.contextPath}/booking"
               class="stat-link">
                View booking details &rarr;
            </a>
        </div>

        <!-- Pending Orders -->
        <div class="stat-card">
            <div class="stat-card-top">
                <span class="stat-icon">&#128722;</span>
                <span class="stat-badge">Processing</span>
            </div>
            <span class="stat-label">Pending Orders</span>
            <p class="stat-value">00</p>
            <p class="stat-note">
                <a href="${pageContext.request.contextPath}/order?action=history"
                   class="stat-link">
                    View order history &rarr;
                </a>
            </p>
        </div>

        <!-- Total Spent -->
        <div class="stat-card">
            <div class="stat-card-top">
                <span class="stat-icon">&#128179;</span>
                <span class="stat-badge">Lifetime</span>
            </div>
            <span class="stat-label">Total Bookings</span>
            <p class="stat-value amount">
                <%= String.format("%02d", totalBookings) %>
            </p>
            <p class="stat-note">
                Member since <%= memberSince %>
            </p>
        </div>

    </div>

    <!-- Tables Row -->
    <div class="tables-row">

        <!-- Recent Bookings -->
        <div>
            <div class="section-header">
                <h2 class="section-title">Recent Bookings</h2>
                <a href="${pageContext.request.contextPath}/booking"
                   class="section-link">Browse History</a>
            </div>
            <div class="data-table-wrapper">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Date & Time</th>
                        <th>Details</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (recentBookings != null &&
                            !recentBookings.isEmpty()) {
                        for (Booking b : recentBookings) { %>
                    <tr>
                        <td>
                                    <span class="table-id">
                                        #RB-<%= b.getBookingId() %>
                                    </span>
                        </td>
                        <td>
                            <p class="table-date">
                                <%= b.getBookingDate() %>
                            </p>
                            <p class="table-time">
                                <%= b.getBookingTime() %>
                            </p>
                        </td>
                        <td>
                            <p class="table-details">
                                        <span class="table-detail-icon">
                                            &#127828;
                                        </span>
                                Table T-<%= String.format(
                                    "%02d", b.getTableNumber()) %>
                            </p>
                            <p class="table-guests">
                                <%= b.getGuestCount() %> Guests
                            </p>
                        </td>
                        <td>
                                    <span class="status-badge
                                          status-<%= b.getStatus() %>">
                                        <%= b.getStatus().toUpperCase() %>
                                    </span>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr class="empty-row">
                        <td colspan="4">
                            No bookings found.
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Recent Orders -->
        <div>
            <div class="section-header">
                <h2 class="section-title">Recent Orders</h2>
                <a href="${pageContext.request.contextPath}/order?action=history"
                   class="section-link">Reorder Favorites</a>
            </div>
            <div class="data-table-wrapper">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Items</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="empty-row">
                        <td colspan="4">
                            No active orders found.
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</div>

<!-- Footer -->
<footer class="page-footer">
    <div class="footer-top">
        <p class="footer-brand">ByteBistro</p>
        <ul class="footer-links">
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Terms of Service</a></li>
            <li><a href="#">Accessibility</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
        <p class="footer-copy">
            &copy; 2024 ByteBistro.
            A Culinary Editorial Experience.
        </p>
    </div>
</footer>

</body>
</html>