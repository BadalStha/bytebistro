<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../components/admin-header.jsp" />

<style>
    :root {
        --primary-red: #8b0000;
        --dark-red: #3d0000;
        --bg-beige: #fcfbe4;
        --accent-pale: #f0f0c8;
        --text-grey: #888;
        --border-color: #e8e8c8;
    }

    body {
        background-color: var(--bg-beige);
        color: var(--dark-red);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }

    h1, h2, h3, .serif {
        font-family: 'Georgia', serif;
    }

    .bill-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;
    }

    .bill-title {
        font-size: 24px;
        letter-spacing: 2px;
        color: var(--primary-red);
        text-transform: uppercase;
    }

    .header-actions {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .btn-print {
        background: transparent;
        border: none;
        color: var(--dark-red);
        font-size: 14px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-paid {
        background: var(--primary-red);
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 1px;
        cursor: pointer;
    }

    .info-cards {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
        margin-bottom: 40px;
    }

    .card-block {
        background: var(--accent-pale);
        padding: 32px;
        border-radius: 8px;
        position: relative;
    }

    .card-label {
        font-size: 10px;
        letter-spacing: 2px;
        text-transform: uppercase;
        color: var(--text-grey);
        margin-bottom: 16px;
    }

    .badge-unpaid {
        position: absolute;
        top: 32px;
        right: 32px;
        background: #f8d7da;
        color: #721c24;
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 10px;
        font-weight: bold;
        text-transform: uppercase;
    }

    .invoice-num {
        font-size: 36px;
        color: var(--primary-red);
        margin-bottom: 24px;
    }

    .meta-info {
        display: flex;
        gap: 40px;
    }

    .meta-group label {
        display: block;
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
        margin-bottom: 4px;
    }

    .meta-group span {
        font-size: 14px;
        color: var(--dark-red);
        font-family: 'Georgia', serif;
    }

    .guest-profile {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-bottom: 24px;
    }

    .guest-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        background: #ddd;
        overflow: hidden;
    }

    .guest-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .guest-name {
        font-size: 18px;
        font-family: 'Georgia', serif;
        color: var(--dark-red);
    }

    .guest-status {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #856404;
    }

    .guest-details {
        display: grid;
        grid-template-columns: 80px 1fr;
        gap: 12px;
        font-size: 13px;
    }

    .guest-details label {
        color: var(--text-grey);
        text-transform: uppercase;
        font-size: 10px;
        letter-spacing: 1px;
    }

    .section-title {
        font-size: 20px;
        color: var(--primary-red);
        margin-bottom: 24px;
    }

    .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 40px;
    }

    .order-table th {
        text-align: left;
        padding: 16px 0;
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: var(--text-grey);
        border-bottom: 1px solid var(--border-color);
    }

    .order-table td {
        padding: 24px 0;
        border-bottom: 1px solid var(--border-color);
    }

    .item-name {
        font-size: 16px;
        color: var(--primary-red);
        font-family: 'Georgia', serif;
        margin-bottom: 4px;
    }

    .item-desc {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
    }

    .item-val {
        font-size: 14px;
    }

    .item-bold {
        font-weight: bold;
        font-size: 14px;
    }

    .bottom-section {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 40px;
    }

    .payment-card {
        background: white;
        padding: 24px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        gap: 16px;
        margin-bottom: 16px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .card-icon {
        width: 40px;
        height: 24px;
        background: var(--dark-red);
        border-radius: 4px;
    }

    .payment-title {
        font-size: 16px;
        font-family: 'Georgia', serif;
        color: var(--dark-red);
    }

    .payment-desc {
        font-size: 11px;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .info-box {
        background: #f9f5d4;
        padding: 16px 20px;
        border-radius: 8px;
        font-size: 13px;
        color: #856404;
        display: flex;
        gap: 12px;
    }

    .totals-box {
        padding-top: 16px;
    }

    .total-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 16px;
        font-size: 13px;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .total-val {
        color: var(--dark-red);
        font-size: 16px;
        text-transform: none;
    }

    .final-row {
        margin-top: 32px;
        margin-bottom: 16px;
        border-top: 1px solid var(--border-color);
        padding-top: 24px;
    }

    .final-row .total-label {
        font-size: 11px;
    }

    .final-row .total-val {
        font-size: 42px;
        font-family: 'Georgia', serif;
        color: var(--primary-red);
    }

    .btn-receipt {
        background: #111;
        color: white;
        width: 100%;
        padding: 16px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 2px;
        text-transform: uppercase;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
    }

    .footer-note {
        margin-top: 60px;
        text-align: center;
        padding: 40px 0;
        border-top: 1px solid #e0e0e0;
    }

    .footer-note h4 {
        font-size: 18px;
        color: var(--dark-red);
        font-style: italic;
        margin-bottom: 16px;
    }

    .footer-note p {
        font-size: 11px;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .footer-links {
        display: flex;
        justify-content: center;
        gap: 24px;
        margin-top: 16px;
    }

    .footer-links a {
        font-size: 11px;
        color: var(--text-grey);
        text-decoration: none;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

</style>

<div class="bill-header">
    <h1 class="bill-title serif">BILL DETAILS</h1>
    <div class="header-actions">
        <button class="btn-print">🖨️ Print</button>
        <button class="btn-paid">MARK AS PAID</button>
    </div>
</div>

<div class="info-cards">
    <div class="card-block">
        <div class="card-label">BILL REFERENCE</div>
        <div class="badge-unpaid">UNPAID</div>
        <div class="invoice-num serif">#INV-2024-0892</div>
        <div class="meta-info">
            <div class="meta-group">
                <label>ORDER ID</label>
                <span>ORD-88219</span>
            </div>
            <div class="meta-group">
                <label>DATE ISSUED</label>
                <span>October 24, 2024</span>
            </div>
        </div>
    </div>

    <div class="card-block">
        <div class="card-label">GUEST CREDENTIALS</div>
        <div class="guest-profile">
            <div class="guest-avatar">
                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80" alt="Guest">
            </div>
            <div>
                <div class="guest-name">Julian Thorne</div>
                <div class="guest-status">VIP MEMBER • GOLD STATUS</div>
            </div>
        </div>
        <div class="guest-details">
            <label>EMAIL</label>
            <div>j.thorne@concierge.com</div>
            <label>TABLE</label>
            <div>Table 14 (Window Side)</div>
        </div>
    </div>
</div>

<h2 class="section-title serif">Consolidated Order Items</h2>

<table class="order-table">
    <thead>
        <tr>
            <th style="width: 50%;">ITEM DESCRIPTION</th>
            <th>QTY</th>
            <th>UNIT PRICE</th>
            <th style="text-align: right;">SUBTOTAL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <div class="item-name">Wagyu Beef Carpaccio</div>
                <div class="item-desc">APPETIZER • TRUFFLE VINAIGRETTE</div>
            </td>
            <td class="item-val">01</td>
            <td class="item-val">$34.00</td>
            <td class="item-bold" style="text-align: right;">$34.00</td>
        </tr>
        <tr>
            <td>
                <div class="item-name">Pan-Seared Scallops</div>
                <div class="item-desc">MAIN COURSE • CAULIFLOWER PURÉE</div>
            </td>
            <td class="item-val">02</td>
            <td class="item-val">$48.00</td>
            <td class="item-bold" style="text-align: right;">$96.00</td>
        </tr>
        <tr>
            <td>
                <div class="item-name">2018 Château Margaux</div>
                <div class="item-desc">WINE • 750ML BOTTLE</div>
            </td>
            <td class="item-val">01</td>
            <td class="item-val">$420.00</td>
            <td class="item-bold" style="text-align: right;">$420.00</td>
        </tr>
        <tr>
            <td>
                <div class="item-name">Artisanal Bread Service</div>
                <div class="item-desc">SIDES • CULTURED BUTTER</div>
            </td>
            <td class="item-val">01</td>
            <td class="item-val">$12.00</td>
            <td class="item-bold" style="text-align: right;">$12.00</td>
        </tr>
    </tbody>
</table>

<div class="bottom-section">
    <div>
        <div class="card-label">PAYMENT PREFERENCE</div>
        <div class="payment-card">
            <div class="card-icon"></div>
            <div>
                <div class="payment-title">Mastercard Terminal 04</div>
                <div class="payment-desc">ENDING IN • • • • 9201</div>
            </div>
        </div>
        <div class="info-box">
            <i>ℹ️</i>
            <div>The corporate discount has been automatically applied based on the guest's loyalty tier.</div>
        </div>
    </div>

    <div class="totals-box">
        <div class="total-row">
            <span>SUBTOTAL</span>
            <span class="total-val">$562.00</span>
        </div>
        <div class="total-row">
            <span>SERVICE CHARGE (15%)</span>
            <span class="total-val">$84.30</span>
        </div>
        <div class="total-row">
            <span>LOYALTY DISCOUNT</span>
            <span class="total-val" style="color: #b30000;">-$56.20</span>
        </div>
        <div class="total-row final-row">
            <span class="total-label">FINAL AMOUNT DUE</span>
            <span class="total-val">$590.10</span>
        </div>
        <button class="btn-receipt">🖨️ FULL RECEIPT</button>
    </div>
</div>

<div class="footer-note">
    <h4>The Culinary Editorial</h4>
    <p>© 2024 THE CULINARY EDITORIAL. ESTABLISHED IN EXCELLENCE.</p>
    <div class="footer-links">
        <a href="#">PRIVACY POLICY</a>
        <a href="#">TERMS OF SERVICE</a>
        <a href="#">CONTACT US</a>
    </div>
</div>

<jsp:include page="../../components/admin-footer.jsp" />
