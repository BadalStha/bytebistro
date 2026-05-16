<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ page import="com.bytebistro.booking.model.dao.BookingDao" %>
<%@ page import="com.bytebistro.user.model.User" %>
<%@ page import="com.bytebistro.user.model.dao.UserDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    // Get session data
    String fullName = (String) session.getAttribute("fullName");
    Integer userId = (Integer) session.getAttribute("userId");
    
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/pages/common/login.jsp");
        return;
    }

    // Split full name for styling
    String firstName = "Member";
    String lastName = "";
    if (fullName != null && !fullName.isEmpty()) {
        String[] nameParts = fullName.split(" ", 2);
        firstName = nameParts[0];
        lastName = nameParts.length > 1 ? nameParts[1] : "";
    }

    // Fetch user data
    UserDao userDao = new UserDao();
    User user = userDao.getUserById(userId);
    String memberSince = (user != null && user.getCreatedAt() != null)
            ? new java.text.SimpleDateFormat("MMMM yyyy").format(user.getCreatedAt()) : "N/A";

    // Fetch booking data
    BookingDao bookingDao = new BookingDao();
    List<Booking> bookings = bookingDao.getBookingsByUserId(userId);
    int totalBookings = bookingDao.getTotalBookingsByUserId(userId);

    // Count active bookings
    int activeBookings = 0;
    if (bookings != null) {
        for (Booking b : bookings) {
            if ("pending".equals(b.getStatus()) || "confirmed".equals(b.getStatus())) {
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
    
    // Put data in request scope for EL/JSTL
    request.setAttribute("firstName", firstName);
    request.setAttribute("lastName", lastName);
    request.setAttribute("memberSince", memberSince);
    request.setAttribute("activeBookings", activeBookings);
    request.setAttribute("totalBookings", totalBookings);
    request.setAttribute("recentBookings", recentBookings);
%>

<!-- Section: Page Header / Hero -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Welcome back, <span style="font-style: italic; color: var(--bb-accent);">${firstName}</span></h1>
            <p class="bb-page-sub">Your table is always waiting. Review your upcoming reservations and preferences.</p>
        </div>
        <div style="display: flex; gap: 12px;">
            <a href="${pageContext.request.contextPath}/booking" class="bb-btn bb-btn--outline">
                <i class="fa-solid fa-calendar-plus"></i> New Reservation
            </a>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp" class="bb-btn bb-btn--primary">
                <i class="fa-solid fa-utensils"></i> Order Now
            </a>
        </div>
    </div>
</div>

<!-- Section: Stats Overview -->
<div class="bb-stats-grid">
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value"><fmt:formatNumber value="${activeBookings}" pattern="00"/></div>
            <div class="bb-stat-label">Active Bookings</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">00</div>
            <div class="bb-stat-label">Pending Orders</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-crown"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value"><fmt:formatNumber value="${totalBookings}" pattern="00"/></div>
            <div class="bb-stat-label">Lifetime Visits</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-id-card"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value" style="font-size: 1rem; margin-top: 12px;">Elite Member</div>
            <div class="bb-stat-label">Since ${memberSince}</div>
        </div>
    </div>
</div>

<!-- Section: Activity Row -->
<div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 32px;">
    <!-- Recent Bookings -->
    <div class="bb-card">
        <div class="bb-card-header">
            <h3 class="bb-card-title">Recent Reservations</h3>
            <a href="${pageContext.request.contextPath}/booking" class="bb-btn bb-btn--sm bb-btn--outline">View History</a>
        </div>
        <div class="bb-table-wrap">
            <table class="bb-table">
                <thead>
                    <tr>
                        <th>Ref</th>
                        <th>Schedule</th>
                        <th>Details</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty recentBookings}">
                            <c:forEach items="${recentBookings}" var="b">
                                <tr>
                                    <td class="bb-mono">#RB-${b.bookingId}</td>
                                    <td>
                                        <div style="font-weight: 600;">${b.bookingDate}</div>
                                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);">${b.bookingTime}</div>
                                    </td>
                                    <td>
                                        <div style="font-size: 0.85rem;">Table T-${b.tableNumber}</div>
                                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);">${b.guestCount} Guests</div>
                                    </td>
                                    <td>
                                        <span class="bb-badge bb-badge--${b.status eq 'confirmed' ? 'served' : (b.status eq 'pending' ? 'pending' : 'cancelled')}">
                                            ${b.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="bb-empty-state">
                                    <i class="fa-solid fa-calendar-xmark"></i>
                                    No recent reservations found.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Loyalty / Profile Info -->
    <div class="bb-card" style="background: linear-gradient(135deg, var(--bb-surface-2) 0%, var(--bb-bg) 100%); position: relative; overflow: hidden;">
        <div style="position: absolute; top: -20px; right: -20px; font-size: 8rem; color: var(--bb-accent); opacity: 0.05; transform: rotate(15deg);">
            <i class="fa-solid fa-crown"></i>
        </div>
        <h3 class="bb-card-title">Member Privileges</h3>
        <p style="font-size: 0.9rem; color: var(--bb-text-muted); line-height: 1.6; margin-bottom: 24px;">
            As a gold-tier member, you have access to exclusive benefits including priority seating and private event invitations.
        </p>
        
        <div style="display: flex; flex-direction: column; gap: 16px;">
            <div style="display: flex; align-items: center; gap: 12px; padding: 12px; background: var(--bb-accent-soft); border-radius: var(--bb-radius); border: 1px solid var(--bb-accent);">
                <i class="fa-solid fa-star" style="color: var(--bb-accent);"></i>
                <div style="font-size: 0.85rem; font-weight: 600;">10% Reward on Library Wines</div>
            </div>
            <div style="display: flex; align-items: center; gap: 12px; padding: 12px; background: var(--bb-surface); border-radius: var(--bb-radius); border: 1px solid var(--bb-border);">
                <i class="fa-solid fa-bell-concierge" style="color: var(--bb-accent);"></i>
                <div style="font-size: 0.85rem; font-weight: 600;">Priority Waitlist Access</div>
            </div>
        </div>

        <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--bb-border);">
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 8px;">Account Preference</div>
            <a href="${pageContext.request.contextPath}/profile" class="bb-btn bb-btn--outline" style="width: 100%;">Edit Profile</a>
        </div>
    </div>
</div>

<jsp:include page="../../components/user-footer.jsp" />