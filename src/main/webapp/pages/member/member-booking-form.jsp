<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ page import="com.bytebistro.booking.model.TableInfo" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
    List<Booking> bookings =
            (List<Booking>) request.getAttribute("bookings");
    List<TableInfo> tables =
            (List<TableInfo>) request.getAttribute("tables");

    Integer totalBookings =
            (Integer) request.getAttribute("totalBookings");
    if (totalBookings == null) totalBookings = 0;
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Table <span style="font-style: italic; color: var(--bb-accent);">Reservations</span></h1>
    <p class="bb-page-sub">Every meal is a story waiting to be told. Reserve your seat at our culinary stage.</p>
</div>

<%-- Alerts --%>
<c:if test="${not empty requestScope.error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-circle-exclamation"></i>
        ${requestScope.error}
    </div>
</c:if>
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

<!-- Section: Booking Layout -->
<div style="display: grid; grid-template-columns: 1fr 340px; gap: 32px; align-items: start;">
    
    <!-- Left Column: Details & Selection -->
    <div style="display: flex; flex-direction: column; gap: 32px;">
        
        <!-- Reservation Details -->
        <div class="bb-card">
            <h3 class="bb-card-title">Reservation Particulars</h3>
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px;">
                <div class="bb-form-group">
                    <label class="bb-label">Arrival Date</label>
                    <input type="date" id="bookingDate" class="bb-input"
                           min="<%= new java.sql.Date(System.currentTimeMillis()) %>"
                           onchange="fetchTables()"/>
                </div>
                <div class="bb-form-group">
                    <label class="bb-label">Preferred Time</label>
                    <input type="time" id="bookingTime" class="bb-input"
                           onchange="fetchTables()"/>
                </div>
                <div class="bb-form-group">
                    <label class="bb-label">Party Size</label>
                    <select id="guestCount" class="bb-input" onchange="updateSummary()">
                        <% for (int i = 1; i <= 8; i++) { %>
                        <option value="<%= i %>" <%= i == 2 ? "selected" : "" %>>
                            <%= i %> Guest<%= i > 1 ? "s" : "" %>
                        </option>
                        <% } %>
                    </select>
                </div>
            </div>
        </div>

        <!-- Available Tables -->
        <div class="bb-card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                <h3 class="bb-card-title" style="margin-bottom: 0;">Select Your Table</h3>
                <span style="font-size: 0.7rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em; font-weight: 600;">
                    Main Dining Room
                </span>
            </div>
            
            <div id="tableGrid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 16px;">
                <% if (tables != null && !tables.isEmpty()) {
                    for (TableInfo t : tables) { %>
                <div class="bb-card bb-table-selection" id="card_<%= t.getTableId() %>" 
                     onclick="selectTable(<%= t.getTableId() %>, <%= t.getTableNumber() %>, <%= t.getSeatingCapacity() %>)"
                     style="padding: 24px; margin-bottom: 0; cursor: pointer; transition: 0.3s ease; position: relative;">
                    <div class="selection-check" style="position: absolute; top: 12px; right: 12px; opacity: 0; transform: scale(0.5); transition: 0.3s ease;">
                        <i class="fa-solid fa-circle-check" style="color: var(--bb-accent); font-size: 1.25rem;"></i>
                    </div>
                    <div style="font-family: var(--bb-font-display); font-size: 1.75rem; color: #fff; font-weight: 700; margin-bottom: 8px;">
                        T-<%= String.format("%02d", t.getTableNumber()) %>
                    </div>
                    <div style="font-size: 0.8rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">
                        <%= t.getSeatingCapacity() %> Seat Capacity
                    </div>
                    <div style="margin-top: 20px; font-size: 0.75rem; font-weight: 600; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em;">
                        Select Table
                    </div>
                </div>
                <% } } else { %>
                <div style="grid-column: 1 / -1; padding: 48px; text-align: center; background: var(--bb-surface-2); border-radius: var(--bb-radius); border: 1px dashed var(--bb-border); color: var(--bb-text-muted);">
                    <i class="fa-solid fa-calendar-day" style="font-size: 2.5rem; margin-bottom: 16px; opacity: 0.3;"></i>
                    <p>Please select a date and time to see available tables.</p>
                </div>
                <% } %>
            </div>
        </div>

        <!-- My Bookings -->
        <div class="bb-card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
                <h3 class="bb-card-title" style="margin-bottom: 0;">My Recent Bookings</h3>
                <span class="bb-badge bb-badge--info"><%= totalBookings %> Total</span>
            </div>
            
            <div class="bb-table-wrap">
                <table class="bb-table">
                    <thead>
                        <tr>
                            <th>Reference</th>
                            <th>Schedule</th>
                            <th>Table Info</th>
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
                                <div style="font-weight: 600;"><%= b.getBookingDate() %></div>
                                <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getBookingTime() %></div>
                            </td>
                            <td>
                                <div style="font-weight: 600;">Table T-<%= String.format("%02d", b.getTableNumber()) %></div>
                                <div style="font-size: 0.75rem; color: var(--bb-text-muted);"><%= b.getGuestCount() %> Guests</div>
                            </td>
                            <td>
                                <span class="bb-badge bb-badge--<%= b.getStatus().equals("confirmed") ? "served" : (b.getStatus().equals("pending") ? "pending" : "cancelled") %>">
                                    <%= b.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <% if ("pending".equals(b.getStatus())) { %>
                                <form action="${pageContext.request.contextPath}/booking" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="cancel"/>
                                    <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>"/>
                                    <button type="submit" class="bb-btn bb-btn--outline" style="padding: 6px 12px; font-size: 0.75rem;"
                                            onclick="return confirm('Cancel this booking? A fee may apply.')">
                                        Cancel
                                    </button>
                                </form>
                                <% } else { %>
                                <span style="font-size: 0.75rem; color: var(--bb-text-muted);">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5" style="padding: 48px; text-align: center; color: var(--bb-text-muted);">
                                No reservations found in your history.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Right Column: Sidebar -->
    <aside style="display: flex; flex-direction: column; gap: 24px; position: sticky; top: 32px;">
        

        <!-- Reservation Summary -->
        <div class="bb-card" style="background: var(--bb-accent-soft); border-color: var(--bb-accent); position: relative; overflow: hidden;">
            <div style="position: absolute; top: -10px; right: -10px; opacity: 0.1; font-size: 5rem; transform: rotate(15deg);">
                <i class="fa-solid fa-utensils"></i>
            </div>
            <h3 class="bb-card-title" style="color: var(--bb-text); margin-bottom: 20px;">Booking Summary</h3>
            
            <div style="display: flex; flex-direction: column; gap: 12px; margin-bottom: 24px;">
                <div id="tableRow" style="display: none; justify-content: space-between; font-size: 0.85rem;">
                    <span id="tableLabel" style="color: var(--bb-text-muted);">Table</span>
                    <span id="tablePrice" style="font-weight: 600;">Rs. 0.00</span>
                </div>
                <div id="totalRow" style="display: flex; justify-content: space-between; align-items: center; padding-top: 16px; border-top: 1px solid rgba(255,255,255,0.1); margin-top: 16px;">
                <span style="font-weight: 700; color: #fff;">Reservation Deposit</span>
                <span id="totalPrice" style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-accent);">Rs. 500.00</span>
            </div>
            </div>

            <p style="font-size: 0.75rem; color: var(--bb-text-muted); line-height: 1.6; margin-bottom: 24px;">
                A deposit is required to secure your reservation. This amount will be applied as a credit to your final bill.
            </p>

            <form action="${pageContext.request.contextPath}/booking" method="post" id="bookingForm">
                <input type="hidden" id="hiddenTableId" name="tableId" value=""/>
                <input type="hidden" id="hiddenDate" name="bookingDate" value=""/>
                <input type="hidden" id="hiddenTime" name="bookingTime" value=""/>
                <input type="hidden" id="hiddenGuests" name="guestCount" value=""/>
                <button type="submit" class="bb-btn bb-btn--primary" style="width: 100%; padding: 14px;">
                    Confirm Reservation
                </button>
            </form>
        </div>
    </aside>
</div>

<style>
    .bb-table-selection:hover {
        border-color: var(--bb-accent);
        background: var(--bb-surface-2);
        transform: translateY(-4px);
    }
    .bb-table-selection.selected {
        border-color: var(--bb-accent);
        background: var(--bb-accent-soft);
        box-shadow: 0 0 0 1px var(--bb-accent);
    }
    .bb-table-selection.selected .selection-check {
        opacity: 1;
        transform: scale(1);
    }
    .bb-table-selection.selected div:last-child {
        color: #fff;
    }
</style>

<script>
    var selectedTable = null;
    var TABLE_BASE_PRICE = 250.00; // Updated to a more realistic figure for premium dining

    function selectTable(tableId, tableNumber, capacity) {
        document.querySelectorAll('.bb-table-selection').forEach(function(c) {
            c.classList.remove('selected');
            c.querySelector('div:last-child').textContent = 'Select Table';
        });

        var card = document.getElementById('card_' + tableId);
        if (card) {
            card.classList.add('selected');
            card.querySelector('div:last-child').textContent = 'Selected';
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
            tableLabel.textContent = 'Table T-' + String(selectedTable.number).padStart(2, '0') + ' (' + guests + ' Guests)';
            tablePrice.textContent = 'Rs. ' + TABLE_BASE_PRICE.toFixed(2);
            total += TABLE_BASE_PRICE;
        } else {
            tableRow.style.display = 'none';
        }

        document.getElementById('totalPrice').textContent = 'Rs. ' + total.toFixed(2);
    }

    function fetchTables() {
        var date = document.getElementById('bookingDate').value;
        var time = document.getElementById('bookingTime').value;
        if (!date || !time) return;

        var grid = document.getElementById('tableGrid');
        grid.innerHTML = '<div style="grid-column: 1 / -1; padding: 48px; text-align: center; color: var(--bb-accent);">Checking Availability...</div>';
        selectedTable = null;
        updateSummary();

        fetch('${pageContext.request.contextPath}/booking' +
            '?action=getAvailableTables' +
            '&bookingDate=' + date +
            '&bookingTime=' + time)
            .then(function(r) { return r.json(); })
            .then(function(tables) {
                if (tables.error || tables.length === 0) {
                    grid.innerHTML = '<div style="grid-column: 1 / -1; padding: 48px; text-align: center; color: var(--bb-text-muted);">No tables available for the selected slot.</div>';
                    return;
                }
                var html = '';
                tables.forEach(function(t) {
                    var num = String(t.tableNumber).padStart(2, '0');
                    html += '<div class="bb-card bb-table-selection" id="card_' + t.tableId + '" onclick="selectTable(' + t.tableId + ',' + t.tableNumber + ',' + t.seatingCapacity + ')" style="padding: 24px; margin-bottom: 0; cursor: pointer; transition: 0.3s ease; position: relative;">';
                    html += '<div class="selection-check" style="position: absolute; top: 12px; right: 12px; opacity: 0; transform: scale(0.5); transition: 0.3s ease;"><i class="fa-solid fa-circle-check" style="color: var(--bb-accent); font-size: 1.25rem;"></i></div>';
                    html += '<div style="font-family: var(--bb-font-display); font-size: 1.75rem; color: #fff; font-weight: 700; margin-bottom: 8px;">T-' + num + '</div>';
                    html += '<div style="font-size: 0.8rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">' + t.seatingCapacity + ' Seat Capacity</div>';
                    html += '<div style="margin-top: 20px; font-size: 0.75rem; font-weight: 600; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em;">Select Table</div>';
                    html += '</div>';
                });
                grid.innerHTML = html;
            })
            .catch(function() {
                grid.innerHTML = '<div style="grid-column: 1 / -1; padding: 48px; text-align: center; color: var(--bb-danger);">Error synchronizing with floor map.</div>';
            });
    }

    document.getElementById('bookingForm').addEventListener('submit', function(e) {
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
            alert('Please select a table from the floor map.');
            e.preventDefault(); return;
        }

        document.getElementById('hiddenTableId').value = selectedTable.id;
        document.getElementById('hiddenDate').value = date;
        document.getElementById('hiddenTime').value = time;
        document.getElementById('hiddenGuests').value = guests;
    });
    // Handle page load
    window.onload = function() {
        fetchTables();
        updateSummary();
    };
</script>

<jsp:include page="../../components/user-footer.jsp" />