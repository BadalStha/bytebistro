<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../components/admin-header.jsp" />

<style>
    :root {
        --primary-red: #8b0000;
        --dark-red: #3d0000;
        --bg-beige: #fcfbe4;
        --card-white: #ffffff;
        --text-grey: #999;
        --accent-pale: #f0f0c8;
        --active-gold: #e6b400;
        --active-bg: #fdf2a8;
    }

    body {
        background-color: var(--bg-beige);
        color: var(--dark-red);
    }

    .promotions-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 40px;
    }

    .breadcrumb-trail {
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        margin-bottom: 12px;
    }

    .main-title {
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 12px;
        color: var(--dark-red);
    }

    .sub-title {
        font-size: 15px;
        color: var(--text-grey);
        max-width: 700px;
        line-height: 1.6;
        font-style: italic;
    }

    .btn-action-main {
        background-color: var(--dark-red);
        color: white;
        padding: 14px 28px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 1px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .btn-action-main:hover {
        background-color: var(--primary-red);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(61, 0, 0, 0.2);
    }

    .promotions-grid {
        display: grid;
        grid-template-columns: 1fr 340px;
        gap: 32px;
    }

    .promo-card {
        background: var(--card-white);
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.03);
    }

    .list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 32px;
    }

    .list-title {
        font-size: 20px;
        font-weight: bold;
        color: var(--dark-red);
    }

    .filter-search {
        position: relative;
    }

    .filter-search input {
        padding: 10px 16px 10px 40px;
        border: none;
        border-radius: 6px;
        background: var(--accent-pale);
        font-size: 13px;
        width: 240px;
        font-family: inherit;
    }

    .filter-search::before {
        content: "🔍";
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 14px;
        opacity: 0.5;
    }

    /* Table Styles */
    .data-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 12px;
    }

    .data-table th {
        text-align: left;
        padding: 12px 16px;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        background: var(--accent-pale);
        border: none;
    }

    .data-table tr td {
        padding: 24px 16px;
        background: white;
        border-top: 1px solid #f0f0f0;
        border-bottom: 1px solid #f0f0f0;
        vertical-align: middle;
    }

    .data-table tr td:first-child { border-left: 1px solid #f0f0f0; border-top-left-radius: 8px; border-bottom-left-radius: 8px; }
    .data-table tr td:last-child { border-right: 1px solid #f0f0f0; border-top-right-radius: 8px; border-bottom-right-radius: 8px; }

    .item-title {
        font-weight: bold;
        font-size: 18px;
        color: var(--primary-red);
        display: block;
        margin-bottom: 6px;
    }

    .item-desc {
        font-size: 12px;
        color: var(--text-grey);
        display: block;
        max-width: 300px;
    }

    .item-highlight {
        font-weight: bold;
        font-size: 20px;
        color: var(--dark-red);
    }

    .item-date {
        font-size: 12px;
        color: var(--text-grey);
        line-height: 1.5;
    }

    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 10px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .status-active { background: var(--active-bg); color: #947e00; }
    .status-inactive { background: #f0f0f0; color: #888; }

    .link-action {
        font-size: 11px;
        font-weight: bold;
        text-transform: uppercase;
        color: var(--primary-red);
        text-decoration: none;
        letter-spacing: 1px;
        transition: color 0.2s;
    }

    .link-action:hover { color: var(--dark-red); text-decoration: underline; }

    /* Sidebar Components */
    .form-sidebar-container {
        display: flex;
        flex-direction: column;
        gap: 24px;
    }

    .form-card-side {
        background: #f5f5dc;
        border: 1px solid #e2e2d0;
        border-radius: 12px;
        padding: 32px;
    }

    .form-label-top {
        display: block;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        margin-bottom: 10px;
    }

    .input-field-custom {
        width: 100%;
        padding: 12px;
        border: 1px solid #dcdcc0;
        border-radius: 6px;
        background: white;
        font-family: inherit;
        font-size: 14px;
        margin-bottom: 24px;
        transition: border-color 0.3s;
    }

    .input-field-custom:focus {
        outline: none;
        border-color: var(--primary-red);
    }

    .textarea-custom {
        height: 100px;
        resize: none;
    }

    .btn-submit-side {
        width: 100%;
        padding: 14px;
        background: transparent;
        border: 2px solid var(--dark-red);
        color: var(--dark-red);
        font-size: 12px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        cursor: pointer;
        transition: all 0.3s;
        border-radius: 4px;
    }

    .btn-submit-side:hover {
        background: var(--dark-red);
        color: white;
    }

    .insights-box {
        background: var(--dark-red);
        color: white;
        padding: 32px;
        border-radius: 12px;
        position: relative;
        overflow: hidden;
    }

    .insights-box h4 {
        font-family: 'Georgia', serif;
        font-size: 18px;
        margin-bottom: 16px;
        font-style: italic;
    }

    .insights-box p {
        font-size: 13px;
        opacity: 0.85;
        line-height: 1.7;
    }

    /* Bottom Stats */
    .summary-stats {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 32px;
        margin-top: 56px;
    }

    .summary-card {
        background: #f5f5dc;
        padding: 32px;
        border-radius: 8px;
        border-bottom: 4px solid var(--accent-pale);
    }

    .summary-label {
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: var(--text-grey);
        margin-bottom: 20px;
        display: block;
    }

    .summary-val {
        font-size: 42px;
        font-weight: bold;
        margin-bottom: 12px;
        color: var(--dark-red);
    }

    .summary-note {
        font-size: 12px;
        color: var(--text-grey);
    }

    .alert {
        padding: 12px 20px;
        border-radius: 6px;
        margin-bottom: 24px;
        font-size: 14px;
    }
    .alert-error { background: #ffe6e6; color: #b30000; border: 1px solid #ffcccc; }
</style>

<div class="promotions-header">
    <div>
        <div class="breadcrumb-trail">Admin / Marketing</div>
        <h1 class="main-title">Promotions Management</h1>
        <p class="sub-title">Curate and oversee active culinary campaigns. Adjust seasonal offerings, loyalty rewards, and exclusive event pricing to elevate the ByteBistro experience.</p>
    </div>
    <button class="btn-action-main" onclick="document.getElementById('promoTitle').focus();">
        <span>+</span> ADD NEW PROMOTION
    </button>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<div class="promotions-grid">
    <!-- List Section -->
    <div class="promo-card">
        <div class="list-header">
            <div class="list-title">Active & Scheduled</div>
            <div class="filter-search">
                <input type="text" placeholder="Filter by title..." onkeyup="filterPromotions(this.value)">
            </div>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th style="width: 45%">Title</th>
                    <th>Discount</th>
                    <th>Validity Period</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="promoTableBody">
                <c:choose>
                    <c:when test="${not empty promotions}">
                        <c:forEach var="promo" items="${promotions}">
                            <tr class="promo-row">
                                <td>
                                    <span class="item-title">${promo.title}</span>
                                    <span class="item-desc">${promo.description}</span>
                                </td>
                                <td class="item-highlight">${promo.discountPercent}%</td>
                                <td class="item-date">
                                    ${promo.validFrom}<br>
                                    <span style="opacity: 0.5">to</span> ${promo.validUntil}
                                </td>
                                <td>
                                    <span class="status-badge ${promo.active ? 'status-active' : 'status-inactive'}">
                                        ${promo.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${promo.active}">
                                            <a href="${pageContext.request.contextPath}/admin/promotion?page=deactivate&id=${promo.promotionId}" 
                                               class="link-action" onclick="return confirm('Deactivate this promotion?')">Deactivate</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/promotion?page=activate&id=${promo.promotionId}" 
                                               class="link-action" onclick="return confirm('Restore this promotion?')">Restore</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 60px; color: var(--text-grey); font-style: italic;">
                                No campaigns currently active. Create one to begin.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- Sidebar Section -->
    <div class="form-sidebar-container">
        <div class="form-card-side" id="addForm">
            <h3 class="list-title" style="margin-bottom: 8px;">Add Promotion</h3>
            <p class="breadcrumb-trail" style="margin-bottom: 32px;">Define campaign parameters</p>

            <form action="${pageContext.request.contextPath}/admin/promotion" method="POST">
                <input type="hidden" name="action" value="add">
                
                <label class="form-label-top">Campaign Title</label>
                <input type="text" name="title" id="promoTitle" class="input-field-custom" placeholder="e.g. Vintage Cellar Tasting" required>

                <label class="form-label-top">Description</label>
                <textarea name="description" class="input-field-custom textarea-custom" placeholder="Briefly outline the promotion's scope..."></textarea>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; align-items: end;">
                    <div>
                        <label class="form-label-top">Discount %</label>
                        <input type="number" name="discountPercent" class="input-field-custom" value="0" min="0" max="100" style="margin-bottom: 24px;">
                    </div>
                    <p style="font-size: 10px; color: var(--text-grey); font-style: italic; margin-bottom: 34px;">Max 40% recommended</p>
                </div>

                <label class="form-label-top">Valid From</label>
                <input type="date" name="validFrom" class="input-field-custom" required>

                <label class="form-label-top">Valid Until</label>
                <input type="date" name="validUntil" class="input-field-custom" required>

                <button type="submit" class="btn-submit-side">Create Promotion</button>
            </form>
        </div>

        <div class="insights-box">
            <h4>Culinary Insights</h4>
            <p>Promotions featuring 'Wine' pairings have seen a 24% higher engagement rate this quarter. Consider adding seasonal tasting events.</p>
            <div style="margin-top: 24px; opacity: 0.2; text-align: right;">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="currentColor"><path d="M11 9H9V2H7V9H5V2H3V9C3 11.12 4.66 12.84 6.75 12.97V22H9.25V12.97C11.34 12.84 13 11.12 13 9V2H11V9ZM16 6V14H18.5V22H21V2C18.24 2 16 4.24 16 6Z"/></svg>
            </div>
        </div>
    </div>
</div>

<div class="summary-stats">
    <div class="summary-card">
        <span class="summary-label">Active Campaigns</span>
        <div class="summary-val">08</div>
        <div class="summary-note"><span style="color: green;">↑</span> +2 from last month</div>
    </div>
    <div class="summary-card">
        <span class="summary-label">Avg. Conversion</span>
        <div class="summary-val">14.2%</div>
        <div class="summary-note">Industry standard: 11%</div>
    </div>
    <div class="summary-card">
        <span class="summary-label">Revenue Impact</span>
        <div class="summary-val">$12.4k</div>
        <div class="summary-note">Attributed to promo codes</div>
    </div>
</div>

<script>
    function filterPromotions(query) {
        const rows = document.querySelectorAll('.promo-row');
        query = query.toLowerCase();
        rows.forEach(row => {
            const title = row.querySelector('.item-title').textContent.toLowerCase();
            const desc = row.querySelector('.item-desc').textContent.toLowerCase();
            if (title.includes(query) || desc.includes(query)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
</script>

<jsp:include page="../../components/admin-footer.jsp" />
