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
        <div class="bb-stat-icon"><i class="fa-solid fa-bag-shopping"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">${not empty totalOrdersCount ? totalOrdersCount : '0'}</div>
            <div class="bb-stat-label">Total Orders</div>
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

<!-- Section: Editorial Banner -->
<div class="bb-card" style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=1600&q=80') center/cover; padding: 60px 40px; color: white;">
    <h2 style="font-family: var(--bb-font-display); font-size: 2.4rem; font-style: italic; margin-bottom: 16px;">The Art of Hospitality</h2>
    <p style="max-width: 540px; line-height: 1.6; opacity: 0.9; font-size: 1.1rem;">Manage your culinary empire with grace and precision. Your evening reservations are performing exceptionally well this week, showing a 24% increase in premium bookings.</p>
</div>

<!-- Section: Recent Orders -->
<div class="bb-card">
    <div class="bb-card-header">
        <h3 class="bb-card-title">Recent Orders</h3>
        <a href="${pageContext.request.contextPath}/admin/report?page=financial" class="bb-btn bb-btn--sm bb-btn--outline">View All Orders</a>
    </div>
    
    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Status</th>
                    <th>Ordered At</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${recentOrders}">
                    <tr>
                        <td class="bb-mono">#BB-${order.orderId}</td>
                        <td>User #${order.userId}</td>
                        <td>
                            <span class="bb-badge ${order.status == 'served' ? 'bb-badge--served' : (order.status == 'cancelled' ? 'bb-badge--cancelled' : 'bb-badge--pending')}">
                                ${order.status}
                            </span>
                        </td>
                        <td><fmt:formatDate value="${order.orderedAt}" pattern="MMM dd, HH:mm" /></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/report?page=financial" class="bb-btn bb-btn--sm bb-btn--outline"><i class="fa-solid fa-eye"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty recentOrders}">
                    <tr>
                        <td colspan="5" class="bb-empty-state">
                            <i class="fa-solid fa-inbox"></i>
                            No recent orders found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="../../components/admin-footer.jsp" />

