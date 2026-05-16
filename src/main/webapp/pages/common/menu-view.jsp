<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../../components/user-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Culinary <span style="font-style: italic; color: var(--bb-accent);">Selection</span></h1>
    <p class="bb-page-sub">Explore our curated menu, where each dish is a masterpiece of flavor and tradition.</p>
</div>

<!-- Section: Menu Categories -->
<div style="display: flex; gap: 32px; margin-bottom: 48px; border-bottom: 1px solid var(--bb-border); padding-bottom: 16px; overflow-x: auto;">
    <a href="${pageContext.request.contextPath}/menu" class="bb-menu-tab ${empty activeCategory ? 'active' : ''}">All Masterpieces</a>
    <a href="${pageContext.request.contextPath}/menu?category=Starter" class="bb-menu-tab ${activeCategory == 'Starter' ? 'active' : ''}">Starter</a>
    <a href="${pageContext.request.contextPath}/menu?category=Main Course" class="bb-menu-tab ${activeCategory == 'Main Course' ? 'active' : ''}">Main Course</a>
    <a href="${pageContext.request.contextPath}/menu?category=Dessert" class="bb-menu-tab ${activeCategory == 'Dessert' ? 'active' : ''}">Dessert</a>
    <a href="${pageContext.request.contextPath}/menu?category=Wine" class="bb-menu-tab ${activeCategory == 'Wine' ? 'active' : ''}">Wine</a>
    <a href="${pageContext.request.contextPath}/menu?category=Whiskey" class="bb-menu-tab ${activeCategory == 'Whiskey' ? 'active' : ''}">Whiskey</a>
    <a href="${pageContext.request.contextPath}/menu?category=Soft Drink" class="bb-menu-tab ${activeCategory == 'Soft Drink' ? 'active' : ''}">Soft Drink</a>
</div>

<!-- Section: Menu Grid -->
<div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 32px; margin-bottom: 80px;">

    <c:forEach var="item" items="${menuItems}">
        <c:if test="${empty activeCategory or item.itemType == activeCategory}">
            <div class="bb-card bb-menu-card">
                <div class="bb-menu-img" style="background-image: url('${pageContext.request.contextPath}/${not empty itemImages[item.itemId] ? itemImages[item.itemId] : 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80'}');">
                    <c:if test="${item.price > 1000}">
                        <span class="bb-menu-badge">Premium Selection</span>
                    </c:if>
                    <c:if test="${not item.available}">
                        <span class="bb-menu-badge" style="background: var(--bb-text-muted); color: white;">Sold Out</span>
                    </c:if>
                </div>
                <div class="bb-menu-content">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
                        <h3 class="bb-menu-dish">${item.name}</h3>
                        <span class="bb-menu-price">Rs. ${item.price}</span>
                    </div>
                    <p class="bb-menu-desc">${item.description}</p>
                    <div style="margin-top: 24px; padding-top: 16px; border-top: 1px solid var(--bb-border); display: flex; justify-content: space-between; align-items: center;">
                        <span style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">${item.itemType}</span>
                        <c:choose>
                            <c:when test="${item.available}">
                                <a href="${not empty sessionScope.userId ? pageContext.request.contextPath.concat('/booking') : pageContext.request.contextPath.concat('/pages/common/register.jsp')}" class="bb-btn bb-btn--outline" style="padding: 6px 16px; font-size: 0.75rem;">Order Now</a>
                            </c:when>
                            <c:otherwise>
                                <button class="bb-btn bb-btn--outline" style="padding: 6px 16px; font-size: 0.75rem; opacity: 0.5; cursor: not-allowed;" disabled>Out of Stock</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>

    <c:if test="${empty menuItems}">
        <div style="grid-column: 1 / -1; padding: 80px 0; text-align: center; border: 1px dashed var(--bb-border); border-radius: 20px;">
            <i class="fa-solid fa-utensils" style="font-size: 3rem; color: var(--bb-border); margin-bottom: 24px; display: block;"></i>
            <h3 style="font-family: var(--bb-font-display); font-size: 1.5rem; margin-bottom: 8px;">The Kitchen is Quiet</h3>
            <p style="color: var(--bb-text-muted);">We are currently updating our culinary selections. Please check back soon.</p>
        </div>
    </c:if>
</div>

<style>
    .bb-menu-tab {
        text-decoration: none;
        color: var(--bb-text-muted);
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.1em;
        padding: 8px 0;
        position: relative;
        transition: 0.3s;
        white-space: nowrap;
    }
    .bb-menu-tab:hover, .bb-menu-tab.active {
        color: var(--bb-accent);
    }
    .bb-menu-tab.active::after {
        content: '';
        position: absolute;
        bottom: -17px;
        left: 0;
        width: 100%;
        height: 2px;
        background: var(--bb-accent);
    }

    .bb-menu-card {
        padding: 0;
        overflow: hidden;
        transition: 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    .bb-menu-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.4);
        border-color: var(--bb-accent-soft);
    }
    .bb-menu-img {
        height: 220px;
        background-size: cover;
        background-position: center;
        position: relative;
    }
    .bb-menu-badge {
        position: absolute;
        top: 16px;
        right: 16px;
        background: var(--bb-accent);
        color: #0f0f0f;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.7rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }
    .bb-menu-content {
        padding: 24px;
    }
    .bb-menu-dish {
        font-family: var(--bb-font-display);
        font-size: 1.4rem;
        color: #fff;
    }
    .bb-menu-price {
        font-family: var(--bb-font-mono);
        color: var(--bb-accent);
        font-weight: 600;
        font-size: 1.1rem;
    }
    .bb-menu-desc {
        color: var(--bb-text-muted);
        font-size: 0.9rem;
        line-height: 1.6;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 4.8em;
    }
</style>

<jsp:include page="../../components/user-footer.jsp" />