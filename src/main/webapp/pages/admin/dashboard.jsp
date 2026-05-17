<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../components/admin-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Management Dashboard</h1>
            <p class="bb-page-sub">Welcome back, Administrator. Here's what's happening at ByteBistro today.</p>
        </div>
        <div style="display: flex; gap: 12px;">
            <a href="${pageContext.request.contextPath}/admin/menu?page=add" class="bb-btn bb-btn--outline">
                <i class="fa-solid fa-plus"></i> Add Menu Item
            </a>
            <a href="${pageContext.request.contextPath}/admin/promotion" class="bb-btn bb-btn--primary">
                <i class="fa-solid fa-bullhorn"></i> New Promotion
            </a>
        </div>
    </div>
</div>

<!-- Section: KPI Stats -->
<div class="bb-stats-grid">
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">${not empty totalBookingsCount ? totalBookingsCount : '0'}</div>
            <div class="bb-stat-label">Total Bookings</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-bolt"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">${not empty activePromosCount ? activePromosCount : '0'}</div>
            <div class="bb-stat-label">Active Promos</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-utensils"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">${not empty menuItemsCount ? menuItemsCount : '0'}</div>
            <div class="bb-stat-label">Menu Items</div>
        </div>
    </div>
</div>


<!-- Section: Recent Bookings -->
<div class="bb-card">
    <div class="bb-card-header">
        <h3 class="bb-card-title">Recent Bookings</h3>
        <a href="${pageContext.request.contextPath}/admin/reservations" class="bb-btn bb-btn--sm bb-btn--outline">View All Bookings</a>
    </div>

    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
            <tr>
                <th>Booking ID</th>
                <th>Customer</th>
                <th>Status</th>
                <th>Date & Time</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="booking" items="${recentBookings}">
                <tr>
                    <td class="bb-mono">#BK-${booking.bookingId}</td>
                    <td>
                        <div style="font-weight: 600;">${booking.customerName}</div>
                        <div style="font-size: 0.85rem; opacity: 0.7;">${booking.customerEmail}</div>
                    </td>
                    <td>
                            <span class="bb-badge ${booking.status == 'confirmed' ? 'bb-badge--served' : (booking.status == 'cancelled' ? 'bb-badge--cancelled' : 'bb-badge--pending')}">
                                    ${booking.status}
                            </span>
                    </td>
                    <td>
                        <div>${booking.bookingDate}</div>
                        <div style="font-size: 0.85rem; opacity: 0.7;">${booking.bookingTime}</div>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty recentBookings}">
                <tr>
                    <td colspan="4" class="bb-empty-state">
                        <i class="fa-solid fa-inbox"></i>
                        No recent bookings found.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../../components/admin-footer.jsp" />
