<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../components/user-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Connect with <span style="font-style: italic; color: var(--bb-accent);">Us</span></h1>
    <p class="bb-page-sub">Inquire about reservations, private events, or simply share your culinary thoughts.</p>
</div>

<div style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 48px; align-items: start;">
    
    <!-- Left Column: Contact Details -->
    <div style="display: flex; flex-direction: column; gap: 32px;">
        <div class="bb-card">
            <h3 class="bb-card-title">Atelier Location</h3>
            <div style="display: flex; flex-direction: column; gap: 20px;">
                <div style="display: flex; align-items: center; gap: 16px;">
                    <i class="fa-solid fa-location-dot" style="color: var(--bb-accent); width: 20px; text-align: center;"></i>
                    <div style="font-size: 0.95rem; color: var(--bb-text);">123 Bistro Street, Kathmandu, Nepal</div>
                </div>
                <div style="display: flex; align-items: center; gap: 16px;">
                    <i class="fa-solid fa-phone" style="color: var(--bb-accent); width: 20px; text-align: center;"></i>
                    <div style="font-size: 0.95rem; color: var(--bb-text);">+977-01-1234567</div>
                </div>
                <div style="display: flex; align-items: center; gap: 16px;">
                    <i class="fa-solid fa-envelope" style="color: var(--bb-accent); width: 20px; text-align: center;"></i>
                    <div style="font-size: 0.95rem; color: var(--bb-text);">concierge@bytebistro.com</div>
                </div>
            </div>
        </div>

        <div class="bb-card" style="background: var(--bb-surface-2);">
            <h3 class="bb-card-title" style="font-size: 1rem;">Hours of Service</h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; font-size: 0.85rem; color: var(--bb-text-muted);">
                <span>Mon — Thu</span>
                <span style="color: var(--bb-text); font-weight: 600;">10:00 — 22:00</span>
                <span>Fri — Sat</span>
                <span style="color: var(--bb-text); font-weight: 600;">10:00 — 23:30</span>
                <span>Sunday</span>
                <span style="color: var(--bb-accent); font-weight: 600;">11:00 — 21:00</span>
            </div>
        </div>
    </div>

    <!-- Right Column: Contact Form -->
    <div class="bb-card" style="padding: 48px;">
        <h3 class="bb-card-title">Send a Private Message</h3>
        <form action="#" method="post">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px;">
                <div class="bb-form-group">
                    <label class="bb-label">Full Name</label>
                    <input type="text" class="bb-input" placeholder="e.g. Julian Escoffier" required />
                </div>
                <div class="bb-form-group">
                    <label class="bb-label">Email Address</label>
                    <input type="email" class="bb-input" placeholder="e.g. julian@example.com" required />
                </div>
            </div>
            <div class="bb-form-group" style="margin-bottom: 32px;">
                <label class="bb-label">Inquiry Details</label>
                <textarea class="bb-input" rows="6" placeholder="How may we assist you today?" required style="padding: 16px;"></textarea>
            </div>
            <button type="submit" class="bb-btn bb-btn--primary" style="padding: 16px 48px; font-size: 1rem;">
                Dispatch Inquiry
            </button>
        </form>
    </div>
</div>

<jsp:include page="../../components/user-footer.jsp" />