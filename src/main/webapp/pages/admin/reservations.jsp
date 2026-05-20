<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/components/admin-header.jsp"/>

<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Integer totalCount = (Integer) request.getAttribute("totalCount");
    if (pendingCount == null) pendingCount = 0L;
    if (totalCount == null) totalCount = 0;
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Reservation Management</h1>
            <p class="bb-page-sub">Review booking requests and verify payment proofs.</p>
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

<!-- Stats -->
<div class="bb-stats-grid">
    <div class="bb-stat-card">
        <div class="bb-stat-icon">
            <i class="fa-solid fa-calendar-check"></i>
        </div>
        <div>
            <div class="bb-stat-value"><%= totalCount %></div>
            <div class="bb-stat-label">Total Bookings</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon" style="background: rgba(232, 160, 69, 0.15);">
            <i class="fa-solid fa-clock" style="color: var(--bb-accent);"></i>
        </div>
        <div>
            <div class="bb-stat-value"><%= pendingCount %></div>
            <div class="bb-stat-label">Pending Approval</div>
        </div>
    </div>
</div>

<!-- Bookings Table -->
<div class="bb-card">
    <div class="bb-card-header">
        <h3 class="bb-card-title" style="margin-bottom: 0;">All Reservations</h3>
    </div>

    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th>Reference</th>
                    <th>Customer</th>
                    <th>Schedule</th>
                    <th>Table</th>
                    <th>Guests</th>
                    <th>Payment Proof</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (bookings != null && !bookings.isEmpty()) {
                    for (Booking b : bookings) { %>
                <tr>
                    <td class="bb-mono" style="font-weight: 600; color: var(--bb-accent);">#BB-<%= b.getBookingId() %></td>
                    <td>
                        <div style="font-weight: 600;"><%= b.getCustomerName() != null ? b.getCustomerName() : "N/A" %></div>
                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getCustomerEmail() != null ? b.getCustomerEmail() : "" %></div>
                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getCustomerPhone() != null ? b.getCustomerPhone() : "" %></div>
                    </td>
                    <td>
                        <div style="font-weight: 600;"><%= b.getBookingDate() %></div>
                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getBookingTime() %></div>
                    </td>
                    <td>
                        <div style="font-weight: 600;">T-<%= String.format("%02d", b.getTableNumber()) %></div>
                        <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getSeatingCapacity() %> Seats</div>
                    </td>
                    <td style="font-weight: 600;"><%= b.getGuestCount() %></td>
                    <td>
                        <% if (b.getPaymentProof() != null && !b.getPaymentProof().isEmpty()) { %>
                        <a href="#" onclick="showPaymentProof('<%= request.getContextPath() + "/" + b.getPaymentProof() %>', '<%= b.getBookingId() %>'); return false;"
                           class="bb-btn bb-btn--sm bb-btn--outline" style="gap: 6px;">
                            <i class="fa-solid fa-image"></i> View
                        </a>
                        <% } else { %>
                        <span style="font-size: 0.8rem; color: var(--bb-text-muted); font-style: italic;">Not uploaded</span>
                        <% } %>
                    </td>
                    <td>
                        <span class="bb-badge bb-badge--<%= b.getStatus().equals("confirmed") ? "served" : (b.getStatus().equals("pending") ? "pending" : "cancelled") %>">
                            <%= b.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <% if ("pending".equals(b.getStatus())) { %>
                        <div style="display: flex; gap: 8px;">
                            <form action="<%= request.getContextPath() %>/admin/reservations" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="confirm"/>
                                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"/>
                                <button type="submit" class="bb-btn bb-btn--sm bb-btn--primary"
                                        onclick="return confirm('Confirm booking #BB-<%= b.getBookingId() %>?')">
                                    <i class="fa-solid fa-check"></i> Confirm
                                </button>
                            </form>
                            <form action="<%= request.getContextPath() %>/admin/reservations" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="reject"/>
                                <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"/>
                                <button type="submit" class="bb-btn bb-btn--sm bb-btn--danger"
                                        onclick="return confirm('Reject booking #BB-<%= b.getBookingId() %>? This cannot be undone.')">
                                    <i class="fa-solid fa-xmark"></i> Reject
                                </button>
                            </form>
                        </div>
                        <% } else { %>
                        <span style="font-size: 0.75rem; color: var(--bb-text-muted);">No actions</span>
                        <% } %>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="8" class="bb-empty-state">
                        <i class="fa-solid fa-calendar-xmark"></i>
                        <span>No reservation requests found.</span>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Payment Proof Modal -->
<div id="proofModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); z-index: 9999; align-items: center; justify-content: center;">
    <div style="background: var(--bb-surface); border: 1px solid var(--bb-border); border-radius: var(--bb-radius-lg); padding: 32px; max-width: 600px; width: 90%; position: relative; animation: bbFadeIn 0.3s ease both;">
        <!-- Close Button -->
        <button onclick="closeModal()" style="position: absolute; top: 16px; right: 16px; background: var(--bb-surface-2); border: 1px solid var(--bb-border); color: var(--bb-text-muted); border-radius: 50%; width: 36px; height: 36px; cursor: pointer; display: flex; align-items: center; justify-content: center; font-size: 1rem; transition: 0.2s;"
                onmouseover="this.style.borderColor='var(--bb-accent)'; this.style.color='var(--bb-accent)'"
                onmouseout="this.style.borderColor='var(--bb-border)'; this.style.color='var(--bb-text-muted)'">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <h3 style="font-family: var(--bb-font-display); font-size: 1.25rem; color: var(--bb-accent); margin-bottom: 8px;">Payment Proof</h3>
        <p id="modalBookingRef" style="font-size: 0.8rem; color: var(--bb-text-muted); margin-bottom: 20px;"></p>

        <div style="border-radius: var(--bb-radius); overflow: hidden; border: 1px solid var(--bb-border); background: var(--bb-surface-2);">
            <img id="proofImage" src="" alt="Payment Proof"
                 style="width: 100%; max-height: 500px; object-fit: contain; display: block;" />
        </div>

        <div style="display: flex; gap: 12px; margin-top: 24px; justify-content: flex-end;">
            <button onclick="closeModal()" class="bb-btn bb-btn--outline bb-btn--sm">Close</button>
        </div>
    </div>
</div>

<script>
    function showPaymentProof(imageSrc, bookingId) {
        var modal = document.getElementById('proofModal');
        var img = document.getElementById('proofImage');
        var ref = document.getElementById('modalBookingRef');

        img.src = imageSrc;
        ref.textContent = 'Booking Reference: #BB-' + bookingId;
        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('proofModal').style.display = 'none';
        document.getElementById('proofImage').src = '';
    }

    // Close modal on backdrop click
    document.getElementById('proofModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });

    // Close modal on Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });
</script>

<jsp:include page="/components/admin-footer.jsp"/>
