<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.bytebistro.rating.model.Rating" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    String fullName = (String) session.getAttribute("fullName");
    Rating existingRating = (Rating) request.getAttribute("existingRating");

    int existingFood = existingRating != null ? existingRating.getFoodRating() : 0;
    int existingStaff = existingRating != null ? existingRating.getStaffRating() : 0;
    int existingAmbience = existingRating != null ? existingRating.getAmbienceRating() : 0;
    String existingComment = existingRating != null && existingRating.getComment() != null ? existingRating.getComment() : "";
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Experience <span style="font-style: italic; color: var(--bb-accent);">Feedback</span></h1>
    <p class="bb-page-sub">Your voice is the vital ingredient in our pursuit of culinary excellence. Share your nuances with us.</p>
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

<div style="display: grid; grid-template-columns: 320px 1fr; gap: 48px; align-items: start;">
    
    <!-- Left Column: Atmosphere & Quote -->
    <div style="display: flex; flex-direction: column; gap: 32px;">
        <div class="bb-card" style="padding: 0; overflow: hidden; border: none;">
            <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=600&q=80" 
                 style="width: 100%; height: 240px; object-fit: cover; filter: brightness(0.7);" alt="Restaurant">
        </div>
        
        <div class="bb-card" style="background: var(--bb-surface-2); border-left: 4px solid var(--bb-accent);">
            <span style="display: block; font-size: 0.7rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.2em; font-weight: 700; margin-bottom: 12px;">PHILOSOPHY</span>
            <p style="font-family: var(--bb-font-display); font-size: 1.25rem; font-style: italic; line-height: 1.6; color: var(--bb-text);">
                &ldquo;A meal is not just food; it is a narrative composed of service, soul, and flavor.&rdquo;
            </p>
        </div>
        
        <c:if test="${not empty existingRating}">
            <div class="bb-card" style="background: var(--bb-accent-soft); border-color: var(--bb-accent); text-align: center;">
                <i class="fa-solid fa-star" style="color: var(--bb-accent); font-size: 2rem; margin-bottom: 12px;"></i>
                <p style="font-size: 0.85rem; font-weight: 600;">You have already shared your thoughts. You may refine your experience below.</p>
            </div>
        </c:if>
    </div>

    <!-- Right Column: Rating Form -->
    <div class="bb-card" style="padding: 48px;">
        <form action="${pageContext.request.contextPath}/rating" method="post" id="ratingForm">
            
            <!-- Category: Food -->
            <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 32px; border-bottom: 1px solid var(--bb-border); margin-bottom: 32px;">
                <div>
                    <h3 style="font-family: var(--bb-font-display); font-size: 1.5rem; color: #fff;">Food Quality</h3>
                    <p style="font-size: 0.85rem; color: var(--bb-text-muted);">The precision and artistry of our culinary team.</p>
                </div>
                <div class="bb-star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="food<%= i %>" name="foodRating" value="<%= i %>" <%= existingFood == i ? "checked" : "" %> />
                    <label for="food<%= i %>"><i class="fa-solid fa-star"></i></label>
                    <% } %>
                </div>
            </div>

            <!-- Category: Staff -->
            <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 32px; border-bottom: 1px solid var(--bb-border); margin-bottom: 32px;">
                <div>
                    <h3 style="font-family: var(--bb-font-display); font-size: 1.5rem; color: #fff;">Staff Behavior</h3>
                    <p style="font-size: 0.85rem; color: var(--bb-text-muted);">The attentiveness and hospitality of our Ma&icirc;tre D&apos;s.</p>
                </div>
                <div class="bb-star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="staff<%= i %>" name="staffRating" value="<%= i %>" <%= existingStaff == i ? "checked" : "" %> />
                    <label for="staff<%= i %>"><i class="fa-solid fa-star"></i></label>
                    <% } %>
                </div>
            </div>

            <!-- Category: Ambience -->
            <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 48px; border-bottom: 1px solid var(--bb-border); margin-bottom: 48px;">
                <div>
                    <h3 style="font-family: var(--bb-font-display); font-size: 1.5rem; color: #fff;">Atmosphere</h3>
                    <p style="font-size: 0.85rem; color: var(--bb-text-muted);">The curated environment and sensory experience.</p>
                </div>
                <div class="bb-star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="ambience<%= i %>" name="ambienceRating" value="<%= i %>" <%= existingAmbience == i ? "checked" : "" %> />
                    <label for="ambience<%= i %>"><i class="fa-solid fa-star"></i></label>
                    <% } %>
                </div>
            </div>

            <div class="bb-form-group" style="margin-bottom: 48px;">
                <label class="bb-label">Elaborate On Your Visit</label>
                <textarea name="comment" class="bb-input" style="height: 160px; padding: 20px;" 
                          placeholder="Tell us about the nuances of your evening..."><%= existingComment %></textarea>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 32px; margin-bottom: 48px;">
                <div class="bb-form-group">
                    <label class="bb-label">Guest Identity</label>
                    <input type="text" class="bb-input" value="<%= fullName != null ? fullName : "" %>" readonly style="opacity: 0.7;" />
                </div>
                <div class="bb-form-group">
                    <label class="bb-label">Account Privilege</label>
                    <input type="text" class="bb-input" value="${not empty sessionScope.userId ? 'Elite Member' : 'Guest Visitor'}" readonly style="opacity: 0.7;" />
                </div>
            </div>

            <div style="display: flex; justify-content: center; gap: 24px; align-items: center;">
                <div style="height: 1px; flex: 1; background: var(--bb-border);"></div>
                <button type="submit" class="bb-btn bb-btn--primary" style="padding: 16px 60px; font-size: 1.1rem;">
                    Submit Experience
                </button>
                <div style="height: 1px; flex: 1; background: var(--bb-border);"></div>
            </div>
        </form>
    </div>
</div>

<style>
    .bb-star-rating {
        display: flex;
        flex-direction: row-reverse;
        gap: 8px;
    }
    .bb-star-rating input {
        display: none;
    }
    .bb-star-rating label {
        font-size: 2.25rem;
        color: var(--bb-surface-2);
        cursor: pointer;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .bb-star-rating label:hover,
    .bb-star-rating label:hover ~ label,
    .bb-star-rating input:checked ~ label {
        color: var(--bb-accent);
    }
    .bb-star-rating label:hover {
        transform: scale(1.2);
    }
</style>

<script>
    document.getElementById('ratingForm').addEventListener('submit', function(e) {
        const categories = ['foodRating', 'staffRating', 'ambienceRating'];
        for (const cat of categories) {
            if (!document.querySelector(`input[name="${cat}"]:checked`)) {
                alert(`Please provide a rating for ${cat.replace('Rating', '')} quality.`);
                e.preventDefault(); return;
            }
        }
    });
</script>

<jsp:include page="../../components/user-footer.jsp" />