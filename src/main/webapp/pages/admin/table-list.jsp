<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/components/admin-header.jsp"/>

<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-start;">
        <div>
            <h1 class="bb-page-title">Table <span style="font-style: italic; color: var(--bb-accent);">Layout</span></h1>
            <p class="bb-page-sub">Configure the physical floor plan of the dining hall.</p>
        </div>
        <div style="display: flex; gap: 12px;">
            <a href="${pageContext.request.contextPath}/admin/tables?action=seed" class="bb-btn bb-btn--outline">
                <i class="fa-solid fa-seedling"></i> Quick Seed (10 Tables)
            </a>
        </div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="bb-alert bb-alert--success">
        <i class="fa-solid fa-circle-check"></i> ${param.success}
    </div>
</c:if>
<c:if test="${not empty param.error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-triangle-exclamation"></i> ${param.error}
    </div>
</c:if>

<div style="display: grid; grid-template-columns: 1fr 340px; gap: 32px; align-items: start;">
    
    <!-- Tables List -->
    <div class="bb-card">
        <h3 class="bb-card-title">Active Tables</h3>
        <div class="bb-table-wrap">
            <table class="bb-table">
                <thead>
                    <tr>
                        <th>Table Number</th>
                        <th>Seating Capacity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="table" items="${tables}">
                        <tr>
                            <td class="bb-mono" style="font-weight: 600;">T-${String.format("%02d", table.tableNumber)}</td>
                            <td>${table.seatingCapacity} Persons</td>
                            <td>
                                <button class="bb-btn bb-btn--danger bb-btn--sm" disabled>
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty tables}">
                        <tr>
                            <td colspan="3" class="bb-empty-state">
                                <i class="fa-solid fa-chair"></i>
                                No tables configured. Add your first table using the panel.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Table Form -->
    <div class="bb-card">
        <h3 class="bb-card-title">New Table</h3>
        <form action="${pageContext.request.contextPath}/admin/tables" method="post">
            <div class="bb-form-group">
                <label class="bb-label">Table Number</label>
                <input type="number" name="tableNumber" class="bb-input" required min="1">
            </div>
            <div class="bb-form-group">
                <label class="bb-label">Capacity</label>
                <select name="capacity" class="bb-input" required>
                    <option value="2">2 Persons</option>
                    <option value="4">4 Persons</option>
                    <option value="6">6 Persons</option>
                    <option value="8">8 Persons</option>
                    <option value="12">Large Group (12)</option>
                </select>
            </div>
            <button type="submit" class="bb-btn bb-btn--primary" style="width: 100%; margin-top: 20px;">
                <i class="fa-solid fa-plus"></i> Add to Floor Plan
            </button>
        </form>
    </div>

</div>

<jsp:include page="/components/admin-footer.jsp"/>
