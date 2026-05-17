<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../components/admin-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Promotions Management</h1>
            <p class="bb-page-sub">Curate and oversee active culinary campaigns and exclusive event pricing.</p>
        </div>
        <button class="bb-btn bb-btn--primary" onclick="document.getElementById('promoTitle').focus();">
            <i class="fa-solid fa-plus"></i> New Promotion
        </button>
    </div>
</div>

<c:if test="${not empty error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-triangle-exclamation"></i> ${error}
    </div>
</c:if>

<div style="display: grid; grid-template-columns: 1fr 360px; gap: 32px;">
    <!-- Main Content: List Section -->
    <div>
        <div class="bb-card">
            <div class="bb-card-header">
                <h3 class="bb-card-title">Active & Scheduled Campaigns</h3>
                <div class="bb-form-group" style="margin-bottom: 0;">
                    <input type="text" class="bb-input" placeholder="Filter by title..." style="width: 240px; border-radius: 30px; padding-left: 20px;" onkeyup="filterPromotions(this.value)">
                </div>
            </div>

            <div class="bb-table-wrap">
                <table class="bb-table">
                    <thead>
                    <tr>
                        <th style="width: 40%">Title & Context</th>
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
                                        <div style="font-weight: 600; color: var(--bb-accent); font-size: 1.05rem; margin-bottom: 4px;">${promo.title}</div>
                                        <div style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.4;">${promo.description}</div>
                                    </td>
                                    <td>
                                        <div style="font-family: var(--bb-font-display); font-size: 1.4rem; font-weight: 700;">${promo.discountPercent}%</div>
                                        <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase;">Reduction</div>
                                    </td>
                                    <td class="bb-mono" style="font-size: 0.8rem;">
                                        <div>${promo.validFrom}</div>
                                        <div style="opacity: 0.5; font-size: 0.7rem; margin: 2px 0;">THROUGH</div>
                                        <div>${promo.validUntil}</div>
                                    </td>
                                    <td>
                                            <span class="bb-badge ${promo.active ? 'bb-badge--active' : 'bb-badge--cancelled'}">
                                                    ${promo.active ? 'Active' : 'Inactive'}
                                            </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${promo.active}">
                                                <a href="${pageContext.request.contextPath}/admin/promotion?page=deactivate&id=${promo.promotionId}"
                                                   class="bb-btn bb-btn--sm bb-btn--danger" onclick="return confirm('Deactivate this promotion?')">
                                                    <i class="fa-solid fa-power-off"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/promotion?page=activate&id=${promo.promotionId}"
                                                   class="bb-btn bb-btn--sm bb-btn--outline" onclick="return confirm('Restore this promotion?')">
                                                    <i class="fa-solid fa-rotate-left"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="bb-empty-state">
                                    <i class="fa-solid fa-bullhorn"></i>
                                    <span>No campaigns currently active. Create one to begin your marketing journey.</span>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Sidebar Section: Form & Insights -->
    <div style="display: flex; flex-direction: column; gap: 24px;">
        <div class="bb-card">
            <h3 class="bb-card-title">Add New Promotion</h3>
            <p class="bb-page-sub" style="margin-bottom: 24px;">Define campaign parameters</p>

            <form action="${pageContext.request.contextPath}/admin/promotion" method="POST">
                <input type="hidden" name="action" value="add">

                <div class="bb-form-group">
                    <label class="bb-label">Campaign Title</label>
                    <input type="text" name="title" id="promoTitle" class="bb-input" placeholder="e.g. Vintage Cellar Tasting" required>
                </div>

                <div class="bb-form-group">
                    <label class="bb-label">Description</label>
                    <textarea name="description" class="bb-input" style="height: 100px; resize: none;" placeholder="Briefly outline the promotion's scope..."></textarea>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="bb-form-group">
                        <label class="bb-label">Discount %</label>
                        <input type="number" name="discountPercent" class="bb-input" value="0" min="0" max="100">
                    </div>
                    <div style="padding-bottom: 24px; display: flex; align-items: center;">
                        <span style="font-size: 0.7rem; color: var(--bb-text-muted); font-style: italic;">Max 40% recommended</span>
                    </div>
                </div>

                <div class="bb-form-group">
                    <label class="bb-label">Valid From</label>
                    <input type="date" name="validFrom" class="bb-input" required>
                </div>

                <div class="bb-form-group">
                    <label class="bb-label">Valid Until</label>
                    <input type="date" name="validUntil" class="bb-input" required>
                </div>

                <button type="submit" class="bb-btn bb-btn--primary" style="width: 100%; margin-top: 12px;">
                    <i class="fa-solid fa-paper-plane"></i> Create Promotion
                </button>
            </form>
        </div>

        <div class="bb-card" style="background: var(--bb-accent-soft); border-color: var(--bb-accent); position: relative; overflow: hidden;">
            <h4 style="font-family: var(--bb-font-display); font-size: 1.2rem; margin-bottom: 12px; font-style: italic; color: var(--bb-accent);">Culinary Insights</h4>
            <p style="font-size: 0.9rem; color: var(--bb-text); line-height: 1.6; opacity: 0.9;">
                Promotions featuring 'Wine' pairings have seen a 24% higher engagement rate this quarter. Consider adding seasonal tasting events to elevate evening bookings.
            </p>
            <div style="position: absolute; right: -10px; bottom: -10px; opacity: 0.1;">
                <i class="fa-solid fa-utensils" style="font-size: 5rem; color: var(--bb-accent);"></i>
            </div>
        </div>
    </div>
</div>

<!-- Section: Summary Stats -->
<div class="bb-stats-grid" style="margin-top: 40px;">
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-chart-pie"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">08</div>
            <div class="bb-stat-label">Active Campaigns</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-users-viewfinder"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">14.2%</div>
            <div class="bb-stat-label">Avg. Conversion</div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-sack-dollar"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">Rs. 12.4k</div>
            <div class="bb-stat-label">Revenue Impact</div>
        </div>
    </div>
</div>

<script>
    function filterPromotions(query) {
        const rows = document.querySelectorAll('.promo-row');
        query = query.toLowerCase();
        rows.forEach(row => {
            const title = row.querySelector('div[style*="font-weight: 600"]').textContent.toLowerCase();
            const desc = row.querySelector('div[style*="font-size: 0.8rem"]').textContent.toLowerCase();
            if (title.includes(query) || desc.includes(query)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
</script>

<jsp:include page="../../components/admin-footer.jsp" />

