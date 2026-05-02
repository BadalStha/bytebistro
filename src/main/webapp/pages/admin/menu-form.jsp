<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/components/admin-header.jsp"/>

<style>
    .form-container { max-width: 900px; margin: 0 auto; display: grid; grid-template-columns: 1fr 300px; gap: 32px; }
    .form-card { background: white; padding: 40px; border-radius: 8px; }
    .form-title { font-size: 42px; color: #8b0000; margin-bottom: 8px; font-weight: bold; }
    .form-subtitle { font-size: 14px; color: #999; font-style: italic; margin-bottom: 32px; }

    .form-group { margin-bottom: 24px; }
    .form-group label { display: block; font-size: 11px; letter-spacing: 1px; color: #999; margin-bottom: 8px; text-transform: uppercase; }
    .form-group input,
    .form-group textarea,
    .form-group select { width: 100%; padding: 12px; border: none; border-bottom: 1px solid #ddd; font-family: 'Georgia', serif; font-size: 14px; color: #555; }
    .form-group input::placeholder { color: #ccc; }
    .form-group textarea { resize: vertical; min-height: 120px; }
    .form-group input:focus,
    .form-group textarea:focus,
    .form-group select:focus { outline: none; border-bottom-color: #8b0000; }

    .toggle-group { display: flex; align-items: center; gap: 12px; }
    .toggle-label { font-size: 12px; letter-spacing: 1px; color: #999; }
    .toggle { width: 50px; height: 28px; background: #8b0000; border-radius: 14px; cursor: pointer; position: relative; transition: 0.3s; }
    .toggle.off { background: #ddd; }
    .toggle-dot { width: 24px; height: 24px; background: white; border-radius: 50%; position: absolute; top: 2px; left: 2px; transition: 0.3s; }
    .toggle.on .toggle-dot { left: 24px; }
    .toggle-input { display: none; }

    .button-group { display: flex; gap: 12px; margin-top: 32px; }
    .btn { padding: 12px 28px; border: none; border-radius: 4px; font-size: 12px; letter-spacing: 1px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; }
    .btn-save { background: #8b0000; color: white; }
    .btn-save:hover { background: #6b0000; }
    .btn-cancel { background: transparent; border: 1px solid #ddd; color: #666; }
    .btn-cancel:hover { background: #f9f9f9; }

    .form-sidebar { background: white; padding: 32px 24px; border-radius: 8px; }
    .sidebar-title { font-size: 14px; color: #8b0000; margin-bottom: 16px; font-weight: bold; letter-spacing: 1px; }
    .photo-upload { background: #3d3d3a; color: white; padding: 40px 20px; text-align: center; border-radius: 4px; margin-bottom: 20px; cursor: pointer; }
    .photo-upload p { font-size: 11px; letter-spacing: 1px; }
    .tip { background: #fafaf0; padding: 16px; border-radius: 4px; }
    .tip-title { font-size: 12px; color: #8b0000; font-weight: bold; margin-bottom: 8px; }
    .tip-text { font-size: 12px; color: #666; line-height: 1.6; }
    .tip-badge { display: inline-block; background: #f0f0c8; color: #5a5a00; padding: 4px 8px; border-radius: 4px; font-size: 10px; margin-top: 8px; }

    .alert { padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; font-size: 13px; }
    .alert-error { background: #f8d7da; color: #721c24; }
</style>

<div class="form-container">
    <div class="form-card">
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert alert-error"><%= error %></div>
        <%
            }
        %>

        <%
            MenuItem menuItem = (MenuItem) request.getAttribute("menuItem");
            boolean isEdit = menuItem != null;
        %>

        <div class="form-title"><%= isEdit ? "Edit Menu Item" : "Add Menu Item" %></div>
        <div class="form-subtitle">Curate the culinary experience with precision.</div>

        <form method="post" action="<%= isEdit ? request.getContextPath() + "/admin/edit-menu-item" : request.getContextPath() + "/admin/menu" %>">

            <% if (isEdit) { %>
            <input type="hidden" name="itemId" value="<%= menuItem.getItemId() %>">
            <% } else { %>
            <input type="hidden" name="action" value="add">
            <% } %>

            <div class="form-group">
                <label>Item Name</label>
                <input type="text" name="name" value="<%= isEdit ? menuItem.getName() : "" %>"
                       placeholder="e.g. Wagyu Beef Tartare" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" placeholder="Briefly describe the ingredients and preparation method..."><%= isEdit ? menuItem.getDescription() : "" %></textarea>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                <div class="form-group">
                    <label>Price ($)</label>
                    <input type="number" step="0.01" name="price" value="<%= isEdit ? menuItem.getPrice() : "0.00" %>" required>
                </div>
                <div class="form-group">
                    <label>Item Type</label>
                    <select name="itemType" required>
                        <option value="">Select Type</option>
                        <option value="Starter" <%= isEdit && "Starter".equals(menuItem.getItemType()) ? "selected" : "" %>>Starter</option>
                        <option value="Main Course" <%= isEdit && "Main Course".equals(menuItem.getItemType()) ? "selected" : "" %>>Main Course</option>
                        <option value="Dessert" <%= isEdit && "Dessert".equals(menuItem.getItemType()) ? "selected" : "" %>>Dessert</option>
                        <option value="Wine" <%= isEdit && "Wine".equals(menuItem.getItemType()) ? "selected" : "" %>>Wine</option>
                        <option value="Whiskey" <%= isEdit && "Whiskey".equals(menuItem.getItemType()) ? "selected" : "" %>>Whiskey</option>
                        <option value="Soft Drink" <%= isEdit && "Soft Drink".equals(menuItem.getItemType()) ? "selected" : "" %>>Soft Drink</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Availability</label>
                <div class="toggle-group">
                    <div class="toggle <%= isEdit && menuItem.isAvailable() ? "on" : "off" %>" onclick="toggleAvailability(this)">
                        <div class="toggle-dot"></div>
                    </div>
                    <input type="hidden" name="isAvailable" value="<%= isEdit && menuItem.isAvailable() ? "true" : "false" %>" id="availabilityInput">
                    <span class="toggle-label"><%= isEdit && menuItem.isAvailable() ? "Available" : "Unavailable" %></span>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-save">SAVE ITEM</button>
                <a href="<%= request.getContextPath() %>/admin/menu?page=list" class="btn btn-cancel">CANCEL</a>
            </div>
        </form>
    </div>

    <div class="form-sidebar">
        <div class="sidebar-title">Item Photo</div>
        <div class="photo-upload">
            <p>UPLOAD ITEM PHOTO</p>
        </div>

        <div class="tip">
            <div class="tip-title">Editorial Tip</div>
            <div class="tip-text">
                A great description doesn't just list ingredients; it tells a story of origin and craft.
                Mention seasonal sourcing or specialized techniques.
            </div>
            <div class="tip-badge">MAINTAIN PREMIUM STANDARDS</div>
        </div>
    </div>
</div>

<script>
    function toggleAvailability(element) {
        element.classList.toggle('on');
        element.classList.toggle('off');
        const input = document.getElementById('availabilityInput');
        input.value = element.classList.contains('on') ? 'true' : 'false';
        const label = element.nextElementSibling.nextElementSibling;
        label.textContent = element.classList.contains('on') ? 'Available' : 'Unavailable';
    }
</script>

<jsp:include page="/components/admin-footer.jsp"/>