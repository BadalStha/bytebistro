<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.order.model.Order" %>
<%@ page import="com.bytebistro.order.model.OrderItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";

    List<Order> orders = (List<Order>) request.getAttribute("orders");
    int totalOrders = (orders != null) ? orders.size() : 0;
    int loyaltyPoints = totalOrders * 50; // 50 points per order
    
    request.setAttribute("totalOrders", totalOrders);
    request.setAttribute("loyaltyPoints", loyaltyPoints);
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">My <span style="font-style: italic; color: var(--bb-accent);">Gastronomic</span> Archive</h1>
            <p class="bb-page-sub">Review your past selections and re-experience your favorite culinary moments.</p>
        </div>
        <div style="text-align: right;">
            <div style="font-size: 0.65rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.2em; font-weight: 700; margin-bottom: 4px;">Exclusive Access</div>
            <div style="font-family: var(--bb-font-display); font-size: 1.5rem; color: #fff; font-style: italic;">ByteBistro Member</div>
        </div>
    </div>
</div>

<%-- Alerts --%>
<c:if test="${not empty param.success}">
    <div class="bb-alert bb-alert--success">
        <i class="fa-solid fa-circle-check"></i>
        ${param.success}
    </div>
</c:if>
<c:if test="${not empty param.error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-circle-exclamation"></i>
        ${param.error}
    </div>
</c:if>

<!-- Section: Stats Overview -->
<div class="bb-stats-grid">
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-bag-shopping"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value"><fmt:formatNumber value="${totalOrders}" pattern="00"/></div>
            <div class="bb-stat-label">Total Orders</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-trophy"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value"><fmt:formatNumber value="${loyaltyPoints}" pattern="#,###"/></div>
            <div class="bb-stat-label">Loyalty Points</div>
        </div>
    </div>
    <div class="bb-stat-card" style="grid-column: span 2; background: linear-gradient(135deg, var(--bb-surface-2) 0%, var(--bb-bg) 100%); display: flex; flex-direction: row; align-items: center; justify-content: space-between; padding: 24px 40px;">
        <div>
            <div style="font-size: 0.65rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">Signature Recommendation</div>
            <div style="font-family: var(--bb-font-display); font-size: 1.25rem; color: #fff; font-style: italic;">The Autumn Degustation</div>
        </div>
        <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp" class="bb-btn bb-btn--outline">Explore Menu</a>
    </div>
</div>

<!-- Section: Orders Table -->
<div class="bb-card">
    <div class="bb-card-header">
        <h3 class="bb-card-title">Order History</h3>
        <div style="display: flex; gap: 12px;">
            <div class="bb-form-group" style="margin-bottom: 0;">
                <input type="text" class="bb-input" placeholder="Search orders..." style="padding: 8px 16px; font-size: 0.8rem; min-width: 200px;">
            </div>
        </div>
    </div>
    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th>Ref ID</th>
                    <th>Date & Time</th>
                    <th>Selections</th>
                    <th>Investment</th>
                    <th>Status</th>
                    <th style="text-align: right;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td class="bb-mono">#BB-${order.orderId}</td>
                                <td>
                                    <div style="font-weight: 600;">${order.orderedAt}</div>
                                </td>
                                <td>
                                    <div style="font-size: 0.85rem; color: var(--bb-text-muted); max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                        <c:forEach items="${order.orderItems}" var="item" varStatus="loop">
                                            ${item.itemName}${not loop.last ? ', ' : ''}
                                            <c:if test="${loop.index eq 2 and not loop.last}">...</c:if>
                                            <c:if test="${loop.index eq 2}"><c:set var="breakLoop" value="true"/></c:if>
                                        </c:forEach>
                                    </div>
                                </td>
                                <td style="font-weight: 700;">
                                    Rs. <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                </td>
                                <td>
                                    <span class="bb-badge bb-badge--${order.status eq 'delivered' ? 'served' : (order.status eq 'pending' ? 'pending' : 'cancelled')}">
                                        ${order.status}
                                    </span>
                                </td>
                                <td style="text-align: right;">
                                    <c:choose>
                                        <c:when test="${order.status eq 'pending'}">
                                            <form action="${pageContext.request.contextPath}/order" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="cancel"/>
                                                <input type="hidden" name="orderId" value="${order.orderId}"/>
                                                <button type="submit" class="bb-btn bb-btn--sm" style="color: var(--bb-danger); border: none; background: transparent;" onclick="return confirm('Do you wish to retract this order?')">
                                                    Cancel <i class="fa-solid fa-xmark" style="margin-left: 4px;"></i>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/bill?orderId=${order.orderId}" class="bb-btn bb-btn--sm bb-btn--outline" style="padding: 4px 12px; font-size: 0.75rem;">
                                                View Receipt <i class="fa-solid fa-arrow-right" style="margin-left: 6px; font-size: 0.6rem;"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="bb-empty-state">
                                <i class="fa-solid fa-receipt"></i>
                                <div>No orders found in your archive.</div>
                                <a href="${pageContext.request.contextPath}/order" class="bb-btn bb-btn--primary" style="margin-top: 16px;">Place Your First Order</a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
    <div class="bb-card-footer" style="display: flex; justify-content: space-between; align-items: center; padding: 16px 24px;">
        <div style="font-size: 0.75rem; color: var(--bb-text-muted);">
            Showing ${orders != null ? orders.size() : 0} of ${orders != null ? orders.size() : 0} Entries
        </div>
        <div style="display: flex; gap: 8px;">
            <button class="bb-btn bb-btn--sm bb-btn--outline" style="padding: 4px 8px;"><i class="fa-solid fa-chevron-left"></i></button>
            <button class="bb-btn bb-btn--sm bb-btn--outline" style="padding: 4px 8px;"><i class="fa-solid fa-chevron-right"></i></button>
        </div>
    </div>
</div>

<jsp:include page="../../components/user-footer.jsp" />