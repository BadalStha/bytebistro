<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../components/admin-header.jsp" />

<style>
    :root {
        --primary-red: #8b0000;
        --dark-red: #3d0000;
        --bg-beige: #fcfbe4;
        --card-white: #ffffff;
        --text-grey: #888;
        --text-light: #aaa;
        --accent-pale: #f0f0c8;
    }

    body {
        background-color: var(--bg-beige);
        color: var(--dark-red);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }

    .serif {
        font-family: 'Georgia', serif;
    }

    .report-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 32px;
    }

    .header-left .subtitle {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: var(--text-grey);
        margin-bottom: 8px;
    }

    .header-left h1 {
        font-size: 42px;
        color: var(--primary-red);
        font-weight: bold;
    }

    .header-right {
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .date-picker {
        background: #f0f0d8;
        padding: 12px 20px;
        border-radius: 4px;
        font-size: 12px;
        color: #333;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .date-picker label {
        font-size: 9px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
        display: block;
        margin-bottom: 2px;
    }

    .btn-icon {
        background: var(--dark-red);
        color: white;
        border: none;
        width: 48px;
        height: 48px;
        border-radius: 4px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .stats-row {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px;
        margin-bottom: 32px;
    }

    .stat-box {
        background: white;
        padding: 24px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .stat-title {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        margin-bottom: 12px;
    }

    .stat-val {
        font-size: 32px;
        font-weight: bold;
        color: var(--dark-red);
        font-family: 'Georgia', serif;
        margin-bottom: 12px;
    }

    .stat-trend {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .trend-up { color: #2e7d32; }
    .trend-neutral { color: var(--text-grey); }
    .trend-down { color: var(--primary-red); }

    .chart-grid {
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 24px;
        margin-bottom: 40px;
    }

    .chart-card {
        background: white;
        border-radius: 8px;
        padding: 32px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        display: flex;
        flex-direction: column;
    }

    .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;
    }

    .chart-title {
        font-size: 18px;
        font-weight: bold;
        font-family: 'Georgia', serif;
    }

    .chart-legend {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .legend-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: var(--primary-red);
    }

    .chart-placeholder {
        flex: 1;
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        padding: 0 20px;
        position: relative;
    }

    .bar {
        width: 40px;
        background: #eee;
        border-radius: 4px 4px 0 0;
        position: relative;
    }

    .bar.active {
        background: var(--primary-red);
    }

    .bar-label {
        position: absolute;
        bottom: -24px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        color: var(--text-grey);
        text-transform: uppercase;
    }

    .bar-value {
        position: absolute;
        top: -24px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        background: var(--dark-red);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
    }

    .insights-card {
        background: var(--primary-red);
        color: white;
        padding: 40px 32px;
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .insights-title {
        font-size: 24px;
        font-family: 'Georgia', serif;
        margin-bottom: 16px;
    }

    .insights-text {
        font-size: 14px;
        line-height: 1.6;
        opacity: 0.9;
        margin-bottom: 32px;
    }

    .btn-outline {
        background: transparent;
        border: 1px solid rgba(255,255,255,0.3);
        color: white;
        padding: 14px;
        border-radius: 4px;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        font-weight: bold;
        cursor: pointer;
        text-align: center;
        transition: 0.3s;
    }

    .btn-outline:hover {
        background: rgba(255,255,255,0.1);
    }

    .transactions-card {
        background: white;
        border-radius: 8px;
        padding: 32px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .tx-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }

    .tx-title {
        font-size: 18px;
        font-family: 'Georgia', serif;
        font-weight: bold;
    }

    .tx-export {
        font-size: 11px;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
        text-decoration: none;
    }

    .tx-table {
        width: 100%;
        border-collapse: collapse;
    }

    .tx-table th {
        text-align: left;
        padding: 16px 0;
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-light);
        border-bottom: 1px solid #eee;
    }

    .tx-table td {
        padding: 20px 0;
        border-bottom: 1px solid #eee;
        font-size: 14px;
    }

    .tx-customer {
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: bold;
    }

    .tx-customer img {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        object-fit: cover;
    }

    .tx-items {
        color: var(--text-grey);
        font-size: 13px;
        max-width: 250px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .tx-amount {
        font-weight: bold;
        color: var(--dark-red);
    }

    .tx-date {
        color: var(--text-grey);
        font-size: 12px;
        line-height: 1.4;
    }

    .badge {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 10px;
        font-weight: bold;
        text-transform: uppercase;
    }

    .badge-paid { background: #fdf2a8; color: #856404; }
    .badge-pending { background: #f8d7da; color: #721c24; }

    .view-all-tx {
        display: block;
        text-align: center;
        margin-top: 32px;
        font-size: 11px;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 2px;
        text-decoration: none;
        font-weight: bold;
    }

    .footer {
        text-align: center;
        margin-top: 60px;
        padding-top: 40px;
        border-top: 1px solid #e0e0e0;
    }

    .footer-links {
        display: flex;
        justify-content: center;
        gap: 24px;
        margin-bottom: 16px;
    }

    .footer-links a {
        font-size: 11px;
        color: var(--text-grey);
        text-decoration: none;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .footer p {
        font-size: 11px;
        color: var(--text-light);
        text-transform: uppercase;
        letter-spacing: 1px;
    }
</style>

<div class="report-header">
    <div class="header-left">
        <div class="subtitle">ADMINISTRATIVE DASHBOARD</div>
        <h1 class="serif">Financial Report</h1>
    </div>
    <div class="header-right">
        <div class="date-picker">
            <div>
                <label>DATE RANGE</label>
                <span>Oct 01 - Oct 31, 2023 📅</span>
            </div>
        </div>
        <button class="btn-icon">≡</button>
    </div>
</div>

<div class="stats-row">
    <div class="stat-box">
        <div class="stat-title">TOTAL REVENUE</div>
        <div class="stat-val">$124,850.00</div>
        <div class="stat-trend trend-up">↗ +12.4% FROM LAST MONTH</div>
    </div>
    <div class="stat-box">
        <div class="stat-title">TOTAL ORDERS</div>
        <div class="stat-val">1,482</div>
        <div class="stat-trend trend-neutral">■ STABLE TRAFFIC</div>
    </div>
    <div class="stat-box">
        <div class="stat-title">AVG ORDER VALUE</div>
        <div class="stat-val">$84.25</div>
        <div class="stat-trend trend-up">↗ +5.2% INCREASE</div>
    </div>
    <div class="stat-box">
        <div class="stat-title">DISCOUNTS</div>
        <div class="stat-val" style="color: var(--primary-red);">$3,120.40</div>
        <div class="stat-trend trend-down">↘ 2.5% REVENUE IMPACT</div>
    </div>
</div>

<div class="chart-grid">
    <div class="chart-card">
        <div class="chart-header">
            <div class="chart-title">Revenue by Month</div>
            <div class="chart-legend"><div class="legend-dot"></div> GROSS REVENUE</div>
        </div>
        <div class="chart-placeholder">
            <div class="bar" style="height: 30%;"><div class="bar-label">MAY</div></div>
            <div class="bar" style="height: 40%;"><div class="bar-label">JUN</div></div>
            <div class="bar" style="height: 35%;"><div class="bar-label">JUL</div></div>
            <div class="bar" style="height: 50%;"><div class="bar-label">AUG</div></div>
            <div class="bar" style="height: 60%;"><div class="bar-label">SEP</div></div>
            <div class="bar active" style="height: 80%;">
                <div class="bar-value">$124k</div>
                <div class="bar-label">OCT</div>
            </div>
        </div>
    </div>
    
    <div class="insights-card">
        <div>
            <div style="font-size: 24px; margin-bottom: 16px;">💡</div>
            <h3 class="insights-title">Maître d' Insights</h3>
            <p class="insights-text">
                Your revenue peak occurs on <strong>Saturdays between 19:00 and 21:30</strong>. 
                Consider introducing a premium 'Late Night Tasting' menu to capitalize on the high traffic.
            </p>
        </div>
        <button class="btn-outline">GENERATE FULL ANALYSIS</button>
    </div>
</div>

<div class="transactions-card">
    <div class="tx-header">
        <h3 class="tx-title">Recent Transactions</h3>
        <a href="#" class="tx-export">EXPORT CSV 📥</a>
    </div>
    <table class="tx-table">
        <thead>
            <tr>
                <th>ORDER ID</th>
                <th>CUSTOMER</th>
                <th>ITEMS</th>
                <th>AMOUNT</th>
                <th>DATE</th>
                <th>STATUS</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="color: var(--text-grey); font-size: 12px;">#BB-<br>10294</td>
                <td class="tx-customer">
                    <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=100&q=80" alt="Julian">
                    Julian Montgomery
                </td>
                <td class="tx-items">4 Course Tasting Menu, Wine Pairing...</td>
                <td class="tx-amount">$412.50</td>
                <td class="tx-date">Oct 24, 2023 •<br>20:15</td>
                <td><span class="badge badge-paid">PAID</span></td>
            </tr>
            <tr>
                <td style="color: var(--text-grey); font-size: 12px;">#BB-<br>10293</td>
                <td class="tx-customer">
                    <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=80" alt="Elena">
                    Elena Vance
                </td>
                <td class="tx-items">Aged Ribeye, Truffle Fries...</td>
                <td class="tx-amount">$185.00</td>
                <td class="tx-date">Oct 24, 2023 •<br>19:42</td>
                <td><span class="badge badge-paid">PAID</span></td>
            </tr>
            <tr>
                <td style="color: var(--text-grey); font-size: 12px;">#BB-<br>10292</td>
                <td class="tx-customer">
                    <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=80" alt="Marcus">
                    Marcus Chen
                </td>
                <td class="tx-items">Seafood Platter, Sancerre...</td>
                <td class="tx-amount">$294.20</td>
                <td class="tx-date">Oct 24, 2023 •<br>19:15</td>
                <td><span class="badge badge-pending">PENDING</span></td>
            </tr>
        </tbody>
    </table>
    <a href="#" class="view-all-tx">VIEW ALL TRANSACTIONS</a>
</div>

<div class="footer">
    <div class="footer-links">
        <a href="#">PRIVACY POLICY</a>
        <a href="#">TERMS OF SERVICE</a>
        <a href="#">CONTACT MAÎTRE D'</a>
    </div>
    <p>© 2024 BYTEBISTRO EDITORIAL. ALL RIGHTS RESERVED.</p>
</div>

<jsp:include page="../../components/admin-footer.jsp" />
