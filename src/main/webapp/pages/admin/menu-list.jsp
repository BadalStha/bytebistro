<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/components/admin-header.jsp"/>

<style>
    .breadcrumb { font-size: 11px; letter-spacing: 1px; color: #999; margin-bottom: 16px; }
    .breadcrumb span { color: #8b0000; font-weight: bold; }

    .page-header { display: flex; align-items: flex-end; justify-content: space-between; margin-bottom: 32px; flex-wrap: wrap; gap: 16px; }
    .page-title { font-size: 48px; color: #8b0000; font-weight: bold; line-height: 1.1; }
    .header-right { display: flex; align-items: center; gap: 12px; }
    .search-bar { display: flex; align-items: center; background: #f0f0c8; border: 1px solid #ddd; border-radius: 20px; padding: 8px 16px; gap: 8px; }
    .search-bar input { border: none; background: transparent; outline: none; font-size: 13px; color: #555; width: 200px; }
    .btn-add { background: #8b0000; color: white; border: none; padding: 12px 20px; border-radius: 4px; font-size: 12px; letter-spacing: 1px; cursor: pointer; text-decoration: none; display: flex; align-items: center; gap: 6px; }
    .btn-add:hover { background: #6b0000; }

    .alert { padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; font-size: 13px; }
    .alert-error { background: #f8d7da; color: #721c24; }

    .table-container { background: white; border-radius: 8px; overflow: hidden; border: 1px solid #e8e8d0; }
    .table-header { display: grid; grid-template-columns: 100px 1fr 140px 100px 120px 140px; padding: 16px 24px; background: white; border-bottom: 1px solid #f0f0e0; }
    .table-header span { font-size: 11px; letter-spacing: 1px; color: #999; font-weight: normal; }
    .table-row { display: grid; grid-template-columns: 100px 1fr 140px 100px 120px 140px; padding: 20px 24px; border-bottom: 1px solid #f5f5e8; align-items: center; }
    .table-row:last-child { border-bottom: none; }
    .table-row:hover { background: #fafaf0; }
    .item-id { font-size: 12px; color: #8b7355; }
    .item-name { font-size: 15px; color: #3d0000; font-weight: bold; }
    .item-type { font-size: 11px; letter-spacing: 1px; color: #777; text-transform: uppercase; }
    .item-price { font-size: 15px; color: #3d0000; font-weight: bold; }
    .status-badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 10px; letter-spacing: 1px; font-weight: bold; }
    .status-available { background: #f0f0c8; color: #5a5a00; }
    .status-soldout { background: #fde8e8; color: #8b0000; }
    .action-buttons { display: flex; gap: 8px; }
    .btn-edit { background: transparent; border: 1px solid #8b7355; color: #8b7355; padding: 6px 14px; border-radius: 4px; font-size: 11px; cursor: pointer; text-decoration: none; }
    .btn-edit:hover { background: #8b7355; color: white; }
    .btn-delete { background: transparent; border: 1px solid #8b0000; color: #8b0000; padding: 6px 14px; border-radius: 4px; font-size: 11px; cursor: pointer; }
    .btn-delete:hover { background: #8b0000; color: white; }

    .empty-state { text-align: center; padding: 60px 24px; color: #999; }
</style>

<div class="breadcrumb">MANAGEMENT / <span>MENU</span></div>

<div class="page-header">
    <div class="page-title">Menu<br>Management</div>
    <div class="header-right">
        <form method="get" action="<%= request.getContextPath() %>/admin/menu?page=search" style="display:flex;">
            <div class="search-bar">
                <input type="text" name="keyword" placeholder="Search culinary items...">
            </div>
        </form>
        <a href="<%= request.getContextPath() %>/admin/menu?page=add" class="btn-add">+ ADD NEW ITEM</a>
    </div>
</div>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<div class="alert alert-error"><%= error %></div>
<%
    }
%>

<div class="table-container">
    <div class="table-header">
        <span>ID</span>
        <span>ITEM NAME</span>
        <span>TYPE</span>
        <span>PRICE</span>
        <span>STATUS</span>
        <span>ACTIONS</span>
    </div>

    <%
        List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
        if (menuItems == null || menuItems.isEmpty()) {
    %>
    <div class="empty-state">
        <p>No menu items found. Click "Add New Item" to get started.</p>
    </div>
    <%
    } else {
        for (MenuItem item : menuItems) {
    %>
    <div class="table-row">
        <div class="item-id">#BB-<%= String.format("%03d", item.getItemId()) %></div>
        <div class="item-name"><%= item.getName() %></div>
        <div class="item-type"><%= item.getItemType() %></div>
        <div class="item-price">$<%= String.format("%.2f", item.getPrice()) %></div>
        <div>
                <span class="status-badge <%= item.isAvailable() ? "status-available" : "status-soldout" %>">
                    <%= item.isAvailable() ? "AVAILABLE" : "SOLD OUT" %>
                </span>
        </div>
        <div class="action-buttons">
            <a href="<%= request.getContextPath() %>/admin/menu?page=edit&id=<%= item.getItemId() %>"
               class="btn-edit">EDIT</a>
            <button class="btn-delete"
                    onclick="if(confirm('Delete this item?')) window.location='<%= request.getContextPath() %>/admin/menu?page=delete&id=<%= item.getItemId() %>'">
                DELETE
            </button>
        </div>
    </div>
    <%
            }
        }
    %>
</div>

<jsp:include page="/components/admin-footer.jsp"/>
