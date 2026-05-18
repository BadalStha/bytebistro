<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<%@ page import="com.bytebistro.image.model.Image" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/components/admin-header.jsp"/>

<%
    MenuItem menuItem = (MenuItem) request.getAttribute("menuItem");
    Image image = (Image) request.getAttribute("image");
    boolean isEdit = menuItem != null;
%>

<div class="bb-page-header">
    <h1 class="bb-page-title"><%= isEdit ? "Refine Menu Item" : "Create Culinary Item" %></h1>
    <p class="bb-page-sub">Shape the gastronomic identity of ByteBistro.</p>
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

<form method="post" action="<%= isEdit ? request.getContextPath() + "/admin/edit-menu-item" : request.getContextPath() + "/admin/menu" %>" enctype="multipart/form-data">
    <div style="display: grid; grid-template-columns: 1fr 340px; gap: 32px;">

        <!-- Main Form Section -->
        <div class="bb-card">
            <h3 class="bb-card-title">Item Details</h3>

            <% if (isEdit) { %>
            <input type="hidden" name="itemId" value="<%= menuItem.getItemId() %>">
            <% } else { %>
            <input type="hidden" name="action" value="add">
            <% } %>

            <div class="bb-form-group">
                <label class="bb-label">Item Name</label>
                <input type="text" name="name" class="bb-input" value="<%= isEdit ? menuItem.getName() : "" %>"
                       required>
            </div>

            <div class="bb-form-group">
                <label class="bb-label">Description</label>
                <textarea name="description" class="bb-input" style="min-height: 120px; resize: vertical;"
                ><%= isEdit ? menuItem.getDescription() : "" %></textarea>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                <div class="bb-form-group">
                    <label class="bb-label">Price (NPR)</label>
                    <input type="number" step="0.01" name="price" class="bb-input" value="<%= isEdit ? menuItem.getPrice() : "0.00" %>" required>
                </div>
                <div class="bb-form-group">
                    <label class="bb-label">Item Type</label>
                    <select name="itemType" class="bb-input" required>
                        <option value="">Select Category</option>
                        <option value="Starter" <%= isEdit && "Starter".equals(menuItem.getItemType()) ? "selected" : "" %>>Starter</option>
                        <option value="Main Course" <%= isEdit && "Main Course".equals(menuItem.getItemType()) ? "selected" : "" %>>Main Course</option>
                        <option value="Dessert" <%= isEdit && "Dessert".equals(menuItem.getItemType()) ? "selected" : "" %>>Dessert</option>
                        <option value="Wine" <%= isEdit && "Wine".equals(menuItem.getItemType()) ? "selected" : "" %>>Wine</option>
                        <option value="Whiskey" <%= isEdit && "Whiskey".equals(menuItem.getItemType()) ? "selected" : "" %>>Whiskey</option>
                        <option value="Soft Drink" <%= isEdit && "Soft Drink".equals(menuItem.getItemType()) ? "selected" : "" %>>Soft Drink</option>
                    </select>
                </div>
            </div>

            <div class="bb-form-group">
                <label class="bb-label">Availability</label>
                <div style="display: flex; align-items: center; gap: 16px; background: var(--bb-surface-2); padding: 12px 20px; border-radius: var(--bb-radius); border: 1px solid var(--bb-border);">
                    <div id="toggleBtn" class="bb-toggle <%= isEdit && menuItem.isAvailable() ? "active" : "" %>"
                         style="width: 48px; height: 24px; background: var(--bb-border); border-radius: 20px; cursor: pointer; position: relative; transition: 0.3s;"
                         onclick="toggleAvailability()">
                        <div id="toggleDot" style="width: 18px; height: 18px; background: white; border-radius: 50%; position: absolute; top: 3px; left: <%= isEdit && menuItem.isAvailable() ? "27px" : "3px" %>; transition: 0.3s;"></div>
                    </div>
                    <input type="hidden" name="isAvailable" value="<%= isEdit && menuItem.isAvailable() ? "true" : "false" %>" id="availabilityInput">
                    <span id="availabilityLabel" style="font-size: 0.9rem; font-weight: 500; color: <%= isEdit && menuItem.isAvailable() ? "var(--bb-success)" : "var(--bb-text-muted)" %>">
                        <%= isEdit && menuItem.isAvailable() ? "Available for Order" : "Currently Unavailable" %>
                    </span>
                </div>
            </div>

            <div style="display: flex; gap: 16px; margin-top: 40px;">
                <button type="submit" class="bb-btn bb-btn--primary" style="padding: 12px 32px;">
                    <i class="fa-solid fa-cloud-arrow-up"></i> Save Culinary Item
                </button>
                <a href="<%= request.getContextPath() %>/admin/menu?page=list" class="bb-btn bb-btn--outline">
                    Cancel
                </a>
            </div>
        </div>

        <!-- Sidebar Section -->
        <div>
            <div class="bb-card">
                <h3 class="bb-card-title">Item Imagery</h3>
                <div style="background: var(--bb-surface-2); border: 2px dashed var(--bb-border); border-radius: var(--bb-radius); padding: 32px 16px; text-align: center; margin-bottom: 24px; cursor: pointer; transition: 0.2s;"
                     onclick="document.getElementById('itemImage').click();"
                     onmouseover="this.style.borderColor='var(--bb-accent)'"
                     onmouseout="this.style.borderColor='var(--bb-border)'">
                    <i class="fa-solid fa-camera" style="font-size: 2rem; color: var(--bb-accent); margin-bottom: 12px; display: block;"></i>
                    <p style="font-size: 0.8rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em;">Click to upload photo</p>
                    <input type="file" id="itemImage" name="itemImage" accept="image/*" style="display: none;" onchange="previewImage(this)">
                </div>

                <div id="previewContainer" style="<%= (isEdit && image != null) ? "" : "display: none;" %>">
                    <label class="bb-label">Image Preview</label>
                    <div style="border-radius: var(--bb-radius); overflow: hidden; border: 1px solid var(--bb-border);">
                        <img id="imagePreviewTag" src="<%= (isEdit && image != null) ? request.getContextPath() + "/" + image.getImagePath() : "" %>"
                             style="width: 100%; display: block;" alt="Preview">
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<script>
    function toggleAvailability() {
        const btn = document.getElementById('toggleBtn');
        const dot = document.getElementById('toggleDot');
        const input = document.getElementById('availabilityInput');
        const label = document.getElementById('availabilityLabel');

        const isActive = input.value === 'true';

        if (isActive) {
            input.value = 'false';
            btn.style.background = 'var(--bb-border)';
            dot.style.left = '3px';
            label.textContent = 'Currently Unavailable';
            label.style.color = 'var(--bb-text-muted)';
        } else {
            input.value = 'true';
            btn.style.background = 'var(--bb-success)';
            dot.style.left = '27px';
            label.textContent = 'Available for Order';
            label.style.color = 'var(--bb-success)';
        }
    }

    function previewImage(input) {
        const preview = document.getElementById('imagePreviewTag');
        const container = document.getElementById('previewContainer');
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                container.style.display = 'block';
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

<jsp:include page="/components/admin-footer.jsp"/>