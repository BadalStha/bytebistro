<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ page import="com.bytebistro.booking.model.TableInfo" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Table - ByteBistro</title>
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

        .btn-new-booking:hover { background: #6b0000; }

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

        /* ── Page Header ── */
        .page-header {
            text-align: center;
            padding: 48px 24px 32px;
        }

        .page-header h1 {
            font-family: 'Georgia', serif;
            font-size: 52px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 12px;
        }

        .page-header .quote {
            font-family: 'Georgia', serif;
            font-style: italic;
            font-size: 16px;
            color: #666;
        }

        /* ── Main Layout ── */
        .main-layout {
            display: flex;
            gap: 24px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 24px 60px;
            align-items: flex-start;
        }

        /* ── Left Panel ── */
        .left-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 10px 14px;
            border-radius: 4px;
            font-size: 13px;
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

        /* ── Details Card ── */
        .details-card {
            background: #fff;
            border-radius: 8px;
            padding: 28px;
        }

        .details-card h3 {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 24px;
        }

        .details-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 16px;
        }

        .detail-field label {
            display: block;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 8px;
        }

        .detail-field input,
        .detail-field select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #eee;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background: #fafafa;
            outline: none;
            transition: border-color 0.2s;
            font-family: 'Arial', sans-serif;
            cursor: pointer;
        }

        .detail-field input:focus,
        .detail-field select:focus {
            border-color: #8B0000;
            background: #fff;
        }

        /* ── Tables Section ── */
        .tables-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .tables-header h3 {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .floor-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B0000;
        }

        .tables-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }

        /* ── Table Card ── */
        .table-card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
        }

        .table-card:hover { border-color: #8B0000; }

        .table-card.selected {
            background: #8B0000;
            border-color: #8B0000;
        }

        .table-card.selected .table-num,
        .table-card.selected .table-det,
        .table-card.selected .table-ico { color: #fff; }

        .table-card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .table-num {
            font-family: 'Georgia', serif;
            font-size: 28px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .table-ico { font-size: 18px; color: #888; }

        .table-det {
            font-size: 11px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 16px;
        }

        .btn-select {
            width: 100%;
            padding: 8px;
            background: none;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            color: #333;
            transition: all 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .btn-select:hover {
            background: #1a1a1a;
            color: #fff;
            border-color: #1a1a1a;
        }

        .table-card.selected .btn-select {
            background: rgba(255,255,255,0.2);
            border-color: rgba(255,255,255,0.4);
            color: #fff;
        }

        .check-mark {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 22px;
            height: 22px;
            background: #fff;
            border-radius: 50%;
            display: none;
            align-items: center;
            justify-content: center;
            color: #8B0000;
            font-size: 12px;
            font-weight: 700;
        }

        .table-card.selected .check-mark { display: flex; }
        .table-card.selected .table-ico { display: none; }

        .no-tables {
            grid-column: span 3;
            text-align: center;
            padding: 32px;
            background: #fff;
            border-radius: 8px;
            font-size: 14px;
            color: #888;
        }

        /* ── My Bookings ── */
        .bookings-section h3 {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 16px;
        }

        .booking-card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 12px;
        }

        .booking-card-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .booking-id {
            font-family: 'Georgia', serif;
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d1e7dd; color: #0f5132; }
        .status-cancelled { background: #f8d7da; color: #721c24; }

        .booking-details {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 12px;
        }

        .booking-detail-item label {
            display: block;
            font-size: 10px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #aaa;
            margin-bottom: 4px;
        }

        .booking-detail-item p {
            font-size: 13px;
            color: #333;
            font-weight: 500;
        }

        .booking-card-footer {
            border-top: 1px solid #f0f0f0;
            padding-top: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cancellation-fee {
            font-size: 12px;
            color: #8B0000;
        }

        .btn-cancel {
            background: none;
            border: 1px solid #8B0000;
            color: #8B0000;
            padding: 6px 16px;
            border-radius: 4px;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            font-family: 'Arial', sans-serif;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background: #8B0000;
            color: #fff;
        }

        .empty-bookings {
            background: #fff;
            border-radius: 8px;
            padding: 32px;
            text-align: center;
            font-size: 14px;
            color: #888;
        }

        /* ── Right Panel ── */
        .right-panel {
            width: 300px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            gap: 16px;
            position: sticky;
            top: 80px;
        }

        /* ── Wine Image ── */
        .wine-image {
            width: 100%;
            height: 160px;
            border-radius: 8px;
            background: linear-gradient(135deg, #2a1a1a 0%, #4a2a2a 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #c8a96e;
            font-size: 48px;
        }

        /* ── Beverage Card ── */
        .beverage-card {
            background: #fff;
            border-radius: 8px;
            padding: 24px;
        }

        .beverage-card h3 {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
        }

        .beverage-field {
            margin-bottom: 16px;
        }

        .beverage-field label {
            display: block;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 8px;
        }

        .beverage-field select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #eee;
            border-radius: 4px;
            font-size: 13px;
            color: #333;
            background: #fafafa;
            outline: none;
            cursor: pointer;
            transition: border-color 0.2s;
            font-family: 'Arial', sans-serif;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23888' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
        }

        .beverage-field select:focus {
            border-color: #8B0000;
        }

        /* ── Summary Card ── */
        .summary-card {
            background: #3a1a1a;
            border-radius: 8px;
            padding: 24px;
            position: relative;
            overflow: hidden;
        }

        .summary-card::before {
            content: '🍴';
            position: absolute;
            right: -10px;
            bottom: -10px;
            font-size: 80px;
            opacity: 0.08;
        }

        .summary-card h3 {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #ccc;
            margin-bottom: 10px;
        }

        .summary-row.total {
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid rgba(255,255,255,0.15);
        }

        .summary-row.total span:first-child {
            font-family: 'Georgia', serif;
            font-size: 16px;
            font-weight: 700;
            color: #fff;
        }

        .summary-row.total span:last-child {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-weight: 700;
            color: #c8a96e;
        }

        .summary-note {
            font-size: 10px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #888;
            margin: 14px 0;
            line-height: 1.6;
        }

        .btn-confirm {
            width: 100%;
            padding: 14px;
            background: #c8a96e;
            color: #3a1a1a;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .btn-confirm:hover { background: #b8996e; }

        /* ── Footer ── */
        .page-footer {
            padding: 32px 40px;
            border-top: 1px solid #e8e8d0;
            text-align: center;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 32px;
            list-style: none;
            margin-bottom: 12px;
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
            .main-layout { flex-direction: column; }
            .right-panel { width: 100%; position: static; }
            .details-row { grid-template-columns: 1fr; }
            .tables-grid { grid-template-columns: repeat(2, 1fr); }
            .booking-details { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 560px) {
            .tables-grid { grid-template-columns: 1fr; }
            .page-header h1 { font-size: 36px; }
        }
    </style>
</head>
<body>

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
    List<Booking> bookings =
            (List<Booking>) request.getAttribute("bookings");
    List<TableInfo> tables =
            (List<TableInfo>) request.getAttribute("tables");
    List<MenuItem> beverages =
            (List<MenuItem>) request.getAttribute("beverages");
    Integer totalBookings =
            (Integer) request.getAttribute("totalBookings");
    if (totalBookings == null) totalBookings = 0;
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/"
       class="navbar-brand">ByteBistro</a>
    <ul class="navbar-links">
        <li>
            <a href="${pageContext.request.contextPath}/booking"
               class="active">Reservations</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">
                Menu</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order">
                Orders</a>
        </li>
    </ul>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/booking"
           class="btn-new-booking">New Booking</a>
        <div class="user-avatar"><%= initial %></div>
    </div>
</nav>

<!-- Page Header -->
<div class="page-header">
    <h1>Book a Table</h1>
    <p class="quote">
        &ldquo;Every meal is a story waiting to be told.
        Reserve your seat at our culinary stage.&rdquo;
    </p>
</div>

<!-- Main Layout -->
<div class="main-layout">

    <!-- Left Panel -->
    <div class="left-panel">

        <%-- Alerts --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
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

        <!-- Reservation Details -->
        <div class="details-card">
            <h3>Reservation Details</h3>
            <div class="details-row">
                <div class="detail-field">
                    <label>Date</label>
                    <input type="date" id="bookingDate"
                           min="<%= new java.sql.Date(
                                   System.currentTimeMillis()) %>"
                           onchange="fetchTables()"/>
                </div>
                <div class="detail-field">
                    <label>Arrival Time</label>
                    <input type="time" id="bookingTime"
                           onchange="fetchTables()"/>
                </div>
                <div class="detail-field">
                    <label>Party Size</label>
                    <select id="guestCount"
                            onchange="updateSummary()">
                        <% for (int i = 1; i <= 8; i++) { %>
                        <option value="<%= i %>"
                                <%= i == 2 ? "selected" : "" %>>
                            <%= i %> Guest<%= i > 1 ? "s" : "" %>
                        </option>
                        <% } %>
                    </select>
                </div>
            </div>
        </div>

        <!-- Available Tables -->
        <div class="tables-section">
            <div class="tables-header">
                <h3>Available Tables</h3>
                <span class="floor-label">
                    Floor Map: Main Dining Room
                </span>
            </div>
            <div class="tables-grid" id="tablesGrid">
                <%
                    if (tables != null && !tables.isEmpty()) {
                        for (TableInfo t : tables) {
                %>
                <div class="table-card"
                     id="card_<%= t.getTableId() %>"
                     onclick="selectTable(
                         <%= t.getTableId() %>,
                         <%= t.getTableNumber() %>,
                         <%= t.getSeatingCapacity() %>)">
                    <div class="check-mark">&#10003;</div>
                    <div class="table-card-top">
                            <span class="table-num">
                                T-<%= String.format("%02d",
                                    t.getTableNumber()) %>
                            </span>
                        <span class="table-ico">&#127828;</span>
                    </div>
                    <p class="table-det">
                        <%= t.getSeatingCapacity() %> Seats
                    </p>
                    <button type="button" class="btn-select">
                        Select Table
                    </button>
                </div>
                <%
                    }
                } else {
                %>
                <div class="no-tables">
                    Please select a date and time to see
                    available tables.
                </div>
                <% } %>
            </div>
        </div>

        <!-- My Bookings -->
        <div class="bookings-section">
            <h3>My Bookings (<%= totalBookings %>)</h3>
            <% if (bookings != null && !bookings.isEmpty()) {
                for (Booking b : bookings) { %>
            <div class="booking-card">
                <div class="booking-card-top">
                        <span class="booking-id">
                            #BB-<%= b.getBookingId() %>
                        </span>
                    <span class="status-badge
                              status-<%= b.getStatus() %>">
                            <%= b.getStatus().toUpperCase() %>
                        </span>
                </div>
                <div class="booking-details">
                    <div class="booking-detail-item">
                        <label>Table</label>
                        <p>T-<%= String.format("%02d",
                                b.getTableNumber()) %></p>
                    </div>
                    <div class="booking-detail-item">
                        <label>Date</label>
                        <p><%= b.getBookingDate() %></p>
                    </div>
                    <div class="booking-detail-item">
                        <label>Time</label>
                        <p><%= b.getBookingTime() %></p>
                    </div>
                    <div class="booking-detail-item">
                        <label>Guests</label>
                        <p><%= b.getGuestCount() %></p>
                    </div>
                </div>
                <% if ("pending".equals(b.getStatus())) { %>
                <div class="booking-card-footer">
                            <span class="cancellation-fee">
                                <% if (b.getCancellationFee() > 0) { %>
                                    Cancellation Fee: Rs.
                                    <%= String.format("%.2f",
                                            b.getCancellationFee()) %>
                                <% } else { %>
                                    Free Cancellation
                                <% } %>
                            </span>
                    <form action="${pageContext.request.contextPath}/booking"
                          method="post">
                        <input type="hidden" name="action"
                               value="cancel"/>
                        <input type="hidden" name="bookingId"
                               value="<%= b.getBookingId() %>"/>
                        <button type="submit"
                                class="btn-cancel"
                                onclick="return confirm(
                                            'Cancel this booking? ' +
                                            'A fee may apply.')">
                            Cancel
                        </button>
                    </form>
                </div>
                <% } %>
            </div>
            <% } } else { %>
            <div class="empty-bookings">
                You have no bookings yet.
            </div>
            <% } %>
        </div>

    </div>

    <!-- Right Panel -->
    <div class="right-panel">

        <!-- Wine Image -->
        <div class="wine-image">&#127863;</div>

        <!-- Premium Beverage Selection -->
        <div class="beverage-card">
            <h3>Premium Beverage Selection</h3>

            <div class="beverage-field">
                <label>Wine Pairing</label>
                <select id="wineSelect" onchange="updateSummary()">
                    <option value="0">None Selected</option>
                    <%
                        if (beverages != null) {
                            for (MenuItem bev : beverages) {
                                if (bev.getItemType().toLowerCase()
                                        .contains("wine")) {
                    %>
                    <option value="<%= bev.getItemId() %>|<%= bev.getPrice() %>">
                        <%= bev.getName() %> —
                        Rs.<%= String.format("%.2f",
                            bev.getPrice()) %>
                    </option>
                    <%
                                }
                            }
                        }
                    %>
                </select>
            </div>

            <div class="beverage-field">
                <label>Whiskey Reserve</label>
                <select id="whiskeySelect" onchange="updateSummary()">
                    <option value="0">None Selected</option>
                    <%
                        if (beverages != null) {
                            for (MenuItem bev : beverages) {
                                if (bev.getItemType().toLowerCase()
                                        .contains("whiskey") ||
                                        bev.getItemType().toLowerCase()
                                                .contains("whisky")) {
                    %>
                    <option value="<%= bev.getItemId() %>|<%= bev.getPrice() %>">
                        <%= bev.getName() %> —
                        Rs.<%= String.format("%.2f",
                            bev.getPrice()) %>
                    </option>
                    <%
                                }
                            }
                        }
                    %>
                </select>
            </div>
        </div>

        <!-- Reservation Summary -->
        <div class="summary-card">
            <h3>Reservation Summary</h3>

            <div class="summary-row" id="tableRow"
                 style="display:none;">
                <span id="tableLabel">Table</span>
                <span id="tablePrice">Rs. 0.00</span>
            </div>

            <div class="summary-row" id="wineRow"
                 style="display:none;">
                <span id="wineLabel">Wine</span>
                <span id="winePrice">Rs. 0.00</span>
            </div>

            <div class="summary-row" id="whiskeyRow"
                 style="display:none;">
                <span id="whiskeyLabel">Whiskey</span>
                <span id="whiskeyPrice">Rs. 0.00</span>
            </div>

            <div class="summary-row total">
                <span>Advance Payment</span>
                <span id="totalPrice">Rs. 0.00</span>
            </div>

            <p class="summary-note">
                A reservation deposit is required to guarantee
                your table. This amount will be deducted from
                your final bill.
            </p>

            <!-- Booking Form -->
            <form action="${pageContext.request.contextPath}/booking"
                  method="post" id="bookingForm">
                <input type="hidden" id="hiddenTableId"
                       name="tableId" value=""/>
                <input type="hidden" id="hiddenDate"
                       name="bookingDate" value=""/>
                <input type="hidden" id="hiddenTime"
                       name="bookingTime" value=""/>
                <input type="hidden" id="hiddenGuests"
                       name="guestCount" value=""/>
                <input type="hidden" id="hiddenWineId"
                       name="wineItemId" value="0"/>
                <input type="hidden" id="hiddenWhiskeyId"
                       name="whiskeyItemId" value="0"/>
                <button type="submit" class="btn-confirm">
                    Confirm Booking
                </button>
            </form>
        </div>

    </div>
</div>

<!-- Footer -->
<footer class="page-footer">
    <ul class="footer-links">
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
        <li><a href="#">Contact Ma&icirc;tre D&apos;</a></li>
    </ul>
    <p class="footer-copy">
        &copy; 2024 ByteBistro Editorial. All Rights Reserved.
    </p>
</footer>

<script>
    var selectedTable = null;
    var TABLE_BASE_PRICE = 25.00;

    function selectTable(tableId, tableNumber, capacity) {
        document.querySelectorAll('.table-card').forEach(function(c) {
            c.classList.remove('selected');
            var btn = c.querySelector('.btn-select');
            if (btn) btn.textContent = 'Select Table';
        });

        var card = document.getElementById('card_' + tableId);
        if (card) {
            card.classList.add('selected');
            var btn = card.querySelector('.btn-select');
            if (btn) btn.textContent = 'Selected';
        }

        selectedTable = {
            id: tableId,
            number: tableNumber,
            capacity: capacity
        };
        updateSummary();
    }

    function updateSummary() {
        var total = 0;

        // Table row
        var tableRow   = document.getElementById('tableRow');
        var tableLabel = document.getElementById('tableLabel');
        var tablePrice = document.getElementById('tablePrice');

        if (selectedTable) {
            var guests = document.getElementById('guestCount').value;
            tableRow.style.display = 'flex';
            tableLabel.textContent = 'Table T-' +
                String(selectedTable.number).padStart(2, '0') +
                ' (' + guests + ' Guests)';
            tablePrice.textContent = 'Rs. ' +
                TABLE_BASE_PRICE.toFixed(2);
            total += TABLE_BASE_PRICE;
        } else {
            tableRow.style.display = 'none';
        }

        // Wine row
        var wineVal = document.getElementById('wineSelect').value;
        var wineRow   = document.getElementById('wineRow');
        var wineLabel = document.getElementById('wineLabel');
        var winePrice = document.getElementById('winePrice');

        if (wineVal && wineVal !== '0') {
            var wineParts = wineVal.split('|');
            var wineP = parseFloat(wineParts[1]) || 0;
            wineRow.style.display = 'flex';
            wineLabel.textContent = 'Wine Pairing';
            winePrice.textContent = 'Rs. ' + wineP.toFixed(2);
            total += wineP;
            document.getElementById('hiddenWineId').value = wineParts[0];
        } else {
            wineRow.style.display = 'none';
            document.getElementById('hiddenWineId').value = '0';
        }

        // Whiskey row
        var whiskeyVal = document.getElementById('whiskeySelect').value;
        var whiskeyRow   = document.getElementById('whiskeyRow');
        var whiskeyLabel = document.getElementById('whiskeyLabel');
        var whiskeyPrice = document.getElementById('whiskeyPrice');

        if (whiskeyVal && whiskeyVal !== '0') {
            var wParts = whiskeyVal.split('|');
            var whiskeyP = parseFloat(wParts[1]) || 0;
            whiskeyRow.style.display = 'flex';
            whiskeyLabel.textContent = 'Whiskey Reserve';
            whiskeyPrice.textContent = 'Rs. ' + whiskeyP.toFixed(2);
            total += whiskeyP;
            document.getElementById('hiddenWhiskeyId').value = wParts[0];
        } else {
            whiskeyRow.style.display = 'none';
            document.getElementById('hiddenWhiskeyId').value = '0';
        }

        document.getElementById('totalPrice').textContent =
            'Rs. ' + total.toFixed(2);
    }

    function fetchTables() {
        var date = document.getElementById('bookingDate').value;
        var time = document.getElementById('bookingTime').value;
        if (!date || !time) return;

        var grid = document.getElementById('tablesGrid');
        grid.innerHTML =
            '<div class="no-tables">Checking availability...</div>';
        selectedTable = null;
        updateSummary();

        fetch('${pageContext.request.contextPath}/booking' +
            '?action=getAvailableTables' +
            '&bookingDate=' + date +
            '&bookingTime=' + time)
            .then(function(r) { return r.json(); })
            .then(function(tables) {
                if (tables.error || tables.length === 0) {
                    grid.innerHTML =
                        '<div class="no-tables">No tables available ' +
                        'for the selected date and time.</div>';
                    return;
                }
                var html = '';
                tables.forEach(function(t) {
                    var num = String(t.tableNumber).padStart(2, '0');
                    html += '<div class="table-card" id="card_' +
                        t.tableId + '" onclick="selectTable(' +
                        t.tableId + ',' + t.tableNumber + ',' +
                        t.seatingCapacity + ')">';
                    html += '<div class="check-mark">&#10003;</div>';
                    html += '<div class="table-card-top">';
                    html += '<span class="table-num">T-' + num + '</span>';
                    html += '<span class="table-ico">&#127828;</span>';
                    html += '</div>';
                    html += '<p class="table-det">' +
                        t.seatingCapacity + ' Seats</p>';
                    html += '<button type="button" class="btn-select">' +
                        'Select Table</button>';
                    html += '</div>';
                });
                grid.innerHTML = html;
            })
            .catch(function() {
                grid.innerHTML =
                    '<div class="no-tables">Error checking ' +
                    'availability. Please try again.</div>';
            });
    }

    document.getElementById('bookingForm')
        .addEventListener('submit', function(e) {
            var date   = document.getElementById('bookingDate').value;
            var time   = document.getElementById('bookingTime').value;
            var guests = document.getElementById('guestCount').value;

            if (!date) {
                alert('Please select a booking date.');
                e.preventDefault(); return;
            }
            if (!time) {
                alert('Please select an arrival time.');
                e.preventDefault(); return;
            }
            if (!selectedTable) {
                alert('Please select a table.');
                e.preventDefault(); return;
            }

            document.getElementById('hiddenTableId').value = selectedTable.id;
            document.getElementById('hiddenDate').value = date;
            document.getElementById('hiddenTime').value = time;
            document.getElementById('hiddenGuests').value = guests;
        });

    document.getElementById('guestCount')
        .addEventListener('change', updateSummary);
</script>

</body>
</html>