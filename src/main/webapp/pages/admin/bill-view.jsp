<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../components/admin-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Invoice Detail</h1>
            <p class="bb-page-sub">Review consolidated order items and final fiscal settlement.</p>
        </div>
        <div style="display: flex; gap: 12px; align-items: center;">
            <button class="bb-btn bb-btn--outline">
                <i class="fa-solid fa-print"></i> Print Bill
            </button>
            <button class="bb-btn bb-btn--primary">
                <i class="fa-solid fa-check-double"></i> Mark as Settled
            </button>
        </div>
    </div>
</div>

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 32px; margin-bottom: 40px;">
    <!-- Bill Reference Card -->
    <div class="bb-card" style="position: relative;">
        <span class="bb-badge bb-badge--pending" style="position: absolute; top: 24px; right: 24px;">Unpaid</span>
        <h3 class="bb-card-title" style="font-size: 0.75rem; color: var(--bb-text-muted); margin-bottom: 8px;">Bill Reference</h3>
        <div class="bb-mono" style="font-size: 2rem; font-weight: 700; color: var(--bb-accent); margin-bottom: 24px;">#INV-2024-0892</div>
        
        <div style="display: flex; gap: 40px;">
            <div>
                <div style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Order Association</div>
                <div class="bb-mono" style="font-size: 0.9rem; font-weight: 600;">ORD-88219</div>
            </div>
            <div>
                <div style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Emission Date</div>
                <div style="font-size: 0.9rem; font-weight: 600;">October 24, 2024</div>
            </div>
        </div>
    </div>

    <!-- Guest Profile Card -->
    <div class="bb-card">
        <h3 class="bb-card-title" style="font-size: 0.75rem; color: var(--bb-text-muted); margin-bottom: 16px;">Guest Intelligence</h3>
        <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 24px;">
            <div style="width: 56px; height: 56px; border-radius: 50%; border: 2px solid var(--bb-accent); overflow: hidden; padding: 2px;">
                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&h=150&q=80" 
                     style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;" alt="Guest">
            </div>
            <div>
                <div style="font-family: var(--bb-font-display); font-size: 1.25rem; font-weight: 600;">Julian Thorne</div>
                <div style="font-size: 0.7rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em; font-weight: 700;">VIP Member • Gold Status</div>
            </div>
        </div>
        <div style="display: grid; grid-template-columns: 80px 1fr; gap: 12px; font-size: 0.85rem;">
            <label style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; align-self: center;">Contact</label>
            <div style="font-weight: 500;">j.thorne@concierge.com</div>
            <label style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; align-self: center;">Placement</label>
            <div style="font-weight: 500;">Table 14 (Window Vista)</div>
        </div>
    </div>
</div>

<h2 style="font-family: var(--bb-font-display); font-size: 1.5rem; margin-bottom: 24px; font-style: italic;">Consolidated Order Ledger</h2>

<div class="bb-card">
    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th style="width: 50%;">Item Description</th>
                    <th>Qty</th>
                    <th>Unit Rate</th>
                    <th style="text-align: right;">Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div style="font-weight: 600; color: var(--bb-accent);">Wagyu Beef Carpaccio</div>
                        <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase;">Appetizer • Truffle Vinaigrette</div>
                    </td>
                    <td class="bb-mono">01</td>
                    <td class="bb-mono">Rs. 3,400</td>
                    <td class="bb-mono" style="text-align: right; font-weight: 700;">Rs. 3,400</td>
                </tr>
                <tr>
                    <td>
                        <div style="font-weight: 600; color: var(--bb-accent);">Pan-Seared Scallops</div>
                        <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase;">Main Course • Cauliflower Purée</div>
                    </td>
                    <td class="bb-mono">02</td>
                    <td class="bb-mono">Rs. 4,800</td>
                    <td class="bb-mono" style="text-align: right; font-weight: 700;">Rs. 9,600</td>
                </tr>
                <tr>
                    <td>
                        <div style="font-weight: 600; color: var(--bb-accent);">2018 Château Margaux</div>
                        <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase;">Wine • 750ml Library Selection</div>
                    </td>
                    <td class="bb-mono">01</td>
                    <td class="bb-mono">Rs. 42,000</td>
                    <td class="bb-mono" style="text-align: right; font-weight: 700;">Rs. 42,000</td>
                </tr>
                <tr>
                    <td>
                        <div style="font-weight: 600; color: var(--bb-accent);">Artisanal Bread Service</div>
                        <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase;">Sides • Cultured Butter Selection</div>
                    </td>
                    <td class="bb-mono">01</td>
                    <td class="bb-mono">Rs. 1,200</td>
                    <td class="bb-mono" style="text-align: right; font-weight: 700;">Rs. 1,200</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div style="display: grid; grid-template-columns: 1fr 400px; gap: 40px; margin-top: 40px;">
    <div>
        <h3 class="bb-card-title" style="font-size: 0.75rem; color: var(--bb-text-muted); margin-bottom: 16px;">Payment Strategy</h3>
        <div class="bb-card" style="display: flex; align-items: center; gap: 16px; padding: 20px; background: var(--bb-surface-2);">
            <div style="width: 44px; height: 28px; background: #2d2d2d; border-radius: 4px; display: flex; align-items: center; justify-content: center; border: 1px solid #444;">
                <i class="fa-brands fa-cc-mastercard" style="color: #eb001b; font-size: 1.2rem;"></i>
            </div>
            <div>
                <div style="font-weight: 600; font-size: 0.95rem;">Mastercard Terminal 04</div>
                <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">Authorized • Ending in 9201</div>
            </div>
        </div>
        <div style="background: var(--bb-accent-soft); padding: 16px 20px; border-radius: var(--bb-radius); border: 1px solid var(--bb-accent); margin-top: 24px; display: flex; gap: 16px; align-items: flex-start;">
            <i class="fa-solid fa-circle-info" style="color: var(--bb-accent); margin-top: 2px;"></i>
            <p style="font-size: 0.85rem; color: var(--bb-text); line-height: 1.5; opacity: 0.9;">
                The corporate loyalty discount has been automatically applied based on the guest's Gold Tier status.
            </p>
        </div>
    </div>

    <div class="bb-card" style="padding: 32px;">
        <div style="display: flex; justify-content: space-between; margin-bottom: 16px; font-size: 0.85rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em;">
            <span>Subtotal</span>
            <span class="bb-mono" style="color: var(--bb-text); font-weight: 600;">Rs. 56,200</span>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: 16px; font-size: 0.85rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em;">
            <span>Service Charge (10%)</span>
            <span class="bb-mono" style="color: var(--bb-text); font-weight: 600;">Rs. 5,620</span>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: 16px; font-size: 0.85rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em;">
            <span>Loyalty Discount</span>
            <span class="bb-mono" style="color: var(--bb-danger); font-weight: 600;">-Rs. 2,810</span>
        </div>
        
        <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid var(--bb-border);">
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 8px;">Final Amount Due</div>
            <div class="bb-mono" style="font-size: 2.75rem; font-weight: 700; color: var(--bb-accent);">Rs. 59,010</div>
        </div>
        
        <button class="bb-btn bb-btn--primary" style="width: 100%; padding: 16px; margin-top: 32px;">
            <i class="fa-solid fa-receipt"></i> Generate Full Receipt
        </button>
    </div>
</div>

<div style="text-align: center; margin-top: 80px; padding-top: 40px; border-top: 1px solid var(--bb-border); opacity: 0.5;">
    <h4 style="font-family: var(--bb-font-display); font-size: 1.25rem; font-style: italic; color: var(--bb-text); margin-bottom: 12px;">The Culinary Ledger</h4>
    <p style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.15em;">© 2024 BYTEBISTRO FINANCIAL SERVICES. ESTABLISHED IN EXCELLENCE.</p>
</div>

<jsp:include page="../../components/admin-footer.jsp" />

