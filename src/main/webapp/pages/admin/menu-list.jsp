<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/components/admin-header.jsp"/>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Menu Management</h1>
            <p class="bb-page-sub">Curate your restaurant's culinary offerings.</p>
        </div>
        <div style="display: flex; gap: 16px; align-items: center;">
            <form method="get" action="<%= request.getContextPath() %>/admin/menu?page=search" style="display:flex;">
                <div class="bb-form-group" style="margin-bottom: 0;">
                    <input type="text" name="keyword" class="bb-input" placeholder="Search menu..." style="width: 240px; border-radius: 30px; padding-left: 20px;">
                </div>
            </form>
            <a href="<%= request.getContextPath() %>/admin/menu?page=add" class="bb-btn bb-btn--primary">
                <i class="fa-solid fa-plus"></i> Add New Item
            </a>
        </div>
    </div>
</div>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<div class="bb-alert bb-alert--danger">
    <i class="fa-solid fa-triangle-exclamation"></i> <%= error %>
</div>
<%
    }
%>

<!-- Section: Menu Table -->
<div class="bb-card">
    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
                    if (menuItems == null || menuItems.isEmpty()) {
                %>
                <tr>
                    <td colspan="6" class="bb-empty-state">
                        <i class="fa-solid fa-utensils"></i>
                        <span>No menu items found. Get started by adding your first dish.</span>
                    </td>
                </tr>
                <%
                } else {
                    for (MenuItem item : menuItems) {
                %>
                <tr>
                    <td class="bb-mono">#BB-<%= String.format("%03d", item.getItemId()) %></td>
                    <td style="font-weight: 600;"><%= item.getName() %></td>
                    <td class="bb-mono" style="font-size: 0.75rem; text-transform: uppercase;"><%= item.getItemType() %></td>
                    <td style="font-weight: 600;">₨ <%= String.format("%.2f", item.getPrice()) %></td>
                    <td>
                        <span class="bb-badge <%= item.isAvailable() ? "bb-badge--active" : "bb-badge--cancelled" %>">
                            <%= item.isAvailable() ? "Available" : "Sold Out" %>
                        </span>
                    </td>
                    <td>
                        <div style="display: flex; gap: 8px;">
                            <a href="<%= request.getContextPath() %>/admin/menu?page=edit&id=<%= item.getItemId() %>" class="bb-btn bb-btn--sm bb-btn--outline">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </a>
                            <button class="bb-btn bb-btn--sm bb-btn--danger" 
                                    onclick="if(confirm('Are you sure you want to delete this exquisite item?')) window.location='<%= request.getContextPath() %>/admin/menu?page=delete&id=<%= item.getItemId() %>'">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/components/admin-footer.jsp"/>

