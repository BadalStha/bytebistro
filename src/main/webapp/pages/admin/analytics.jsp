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
        --bar-pale: #d2c6b4;
    }

    body {
        background-color: var(--bg-beige);
        color: var(--dark-red);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }

    .serif {
        font-family: 'Georgia', serif;
    }

    .analytics-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 40px;
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
        align-items: center;
        gap: 24px;
    }

    .last-updated {
        text-align: right;
    }

    .last-updated label {
        font-size: 9px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
        display: block;
        margin-bottom: 4px;
    }

    .last-updated span {
        font-size: 12px;
        color: var(--dark-red);
        font-style: italic;
    }

    .btn-refresh {
        background: var(--primary-red);
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn-refresh:hover {
        background: var(--dark-red);
    }

    .top-cards {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        margin-bottom: 40px;
    }

    .card-stat {
        padding: 32px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        position: relative;
    }

    .card-white { background: white; }
    .card-dark { background: var(--dark-red); color: white; }
    .card-accent { background: #f4f6e4; }

    .card-icon {
        position: absolute;
        top: 32px;
        right: 32px;
        font-size: 20px;
    }

    .card-label {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        margin-bottom: 24px;
        opacity: 0.8;
    }

    .card-val {
        font-size: 42px;
        font-family: 'Georgia', serif;
        margin-bottom: 16px;
    }

    .card-desc {
        font-size: 11px;
        line-height: 1.5;
        opacity: 0.9;
    }

    .trend-up {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 11px;
        color: var(--text-grey);
        margin-bottom: 8px;
    }

    .trend-up span { color: #2e7d32; }

    .status-text {
        font-size: 9px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
    }

    .progress-bar {
        width: 100%;
        height: 4px;
        background: rgba(255,255,255,0.2);
        margin-top: 16px;
        border-radius: 2px;
    }

    .progress-fill {
        height: 100%;
        width: 85%;
        background: #e6b400;
        border-radius: 2px;
    }

    .main-grid {
        display: grid;
        grid-template-columns: 1.5fr 1fr;
        gap: 32px;
        margin-bottom: 40px;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }

    .section-title {
        font-size: 20px;
        font-family: 'Georgia', serif;
        color: var(--primary-red);
    }

    .legend {
        display: flex;
        gap: 16px;
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
    }

    .legend-item { display: flex; align-items: center; gap: 6px; }
    .dot-actual { width: 8px; height: 8px; border-radius: 50%; background: var(--primary-red); }
    .dot-predicted { width: 8px; height: 8px; border-radius: 50%; background: #858542; }

    .chart-container {
        background: #f4f3e6;
        border-radius: 8px;
        padding: 40px 32px 0 32px;
        height: 350px;
        display: flex;
        align-items: flex-end;
        justify-content: space-around;
        position: relative;
    }

    .bar {
        width: 45px;
        border-radius: 4px 4px 0 0;
        position: relative;
    }

    .bar-pale { background: var(--bar-pale); }
    .bar-dark { background: var(--dark-red); }
    .bar-forecast { 
        background: transparent; 
        border: 2px dashed #858542; 
        border-bottom: none;
    }

    .bar-label {
        position: absolute;
        bottom: -28px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 10px;
        text-transform: uppercase;
        color: var(--text-grey);
        letter-spacing: 1px;
    }

    .chart-note {
        position: absolute;
        top: 20px;
        right: 40px;
        font-size: 10px;
        font-weight: bold;
        letter-spacing: 1px;
        color: var(--text-grey);
    }

    .chart-note-actual { right: 100px; }

    .velocity-table {
        background: white;
        border-radius: 8px;
        width: 100%;
        border-collapse: collapse;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .velocity-table th {
        text-align: left;
        padding: 16px 24px;
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        border-bottom: 1px solid #eee;
    }

    .velocity-table td {
        padding: 24px;
        border-bottom: 1px solid #eee;
    }

    .rank-num {
        font-family: 'Georgia', serif;
        font-style: italic;
        font-size: 16px;
        color: var(--primary-red);
    }

    .item-name {
        font-weight: bold;
        font-size: 14px;
        color: var(--dark-red);
        margin-bottom: 4px;
    }

    .item-cat {
        font-size: 9px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: var(--text-grey);
    }

    .item-total {
        font-weight: bold;
        font-size: 14px;
        color: var(--primary-red);
        text-align: right;
    }

    .note-box {
        background: #fdfae3;
        border: 1px solid #eee8cc;
        padding: 24px;
        border-radius: 8px;
        font-size: 12px;
        font-style: italic;
        line-height: 1.6;
        color: #666;
        margin-top: 24px;
    }

    .bottom-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 60px;
        padding: 40px 0;
        border-top: 1px solid #e0e0e0;
        background: white;
        padding: 40px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .footer-brand {
        font-family: 'Georgia', serif;
        font-size: 20px;
        font-style: italic;
        color: var(--dark-red);
        width: 25%;
    }

    .footer-copy {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        flex: 1;
        text-align: center;
        border-left: 1px solid #eee;
        padding-left: 24px;
    }

    .footer-links {
        display: flex;
        gap: 24px;
        width: 40%;
        justify-content: flex-end;
    }

    .footer-links a {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        text-decoration: none;
    }

    .footer-links a:hover {
        color: var(--dark-red);
    }
</style>

<div class="analytics-header">
    <div class="header-left">
        <div class="subtitle">INSIGHT DASHBOARD</div>
        <h1 class="serif">Predictive Analytics</h1>
    </div>
    <div class="header-right">
        <div class="last-updated">
            <label>LAST UPDATED</label>
            <span>24 Oct, 2024 - 08:30 PM</span>
        </div>
        <button class="btn-refresh">REFRESH FORECAST</button>
    </div>
</div>

<div class="top-cards">
    <div class="card-stat card-white">
        <div class="card-icon">💵</div>
        <div class="card-label">CURRENT MONTH REVENUE</div>
        <div class="card-val">$142,850</div>
        <div class="trend-up"><span>↗</span> +12.4% vs last month</div>
        <div class="status-text">STATUS: ON TRACK</div>
    </div>
    <div class="card-stat card-dark">
        <div class="card-icon">✨</div>
        <div class="card-label" style="color: #ccc;">PREDICTED NEXT MONTH</div>
        <div class="card-val">$158,200</div>
        <div class="card-desc" style="color: #ccc;">⚙️ High Confidence Model</div>
        <div class="progress-bar"><div class="progress-fill"></div></div>
    </div>
    <div class="card-stat card-accent">
        <div class="card-icon">📅</div>
        <div class="card-label">OPTIMAL PERFORMANCE</div>
        <div class="card-val" style="font-size: 32px; margin-bottom: 24px;">Saturday</div>
        <div class="card-desc">Peak occupancy reached between 7:00 PM and 9:30 PM. Recommended staffing: Tier 1.</div>
    </div>
</div>

<div class="main-grid">
    <div>
        <div class="section-header">
            <div class="section-title">Revenue Trend Analysis</div>
            <div class="legend">
                <div class="legend-item"><div class="dot-actual"></div> ACTUAL</div>
                <div class="legend-item"><div class="dot-predicted"></div> PREDICTED</div>
            </div>
        </div>
        <div class="chart-container">
            <div class="chart-note chart-note-actual" style="top: 150px;">CURRENT</div>
            <div class="chart-note" style="top: 135px; color: #858542;">FORECAST</div>
            
            <div class="bar bar-pale" style="height: 30%;"><div class="bar-label">MAY</div></div>
            <div class="bar bar-pale" style="height: 40%;"><div class="bar-label">JUN</div></div>
            <div class="bar bar-pale" style="height: 35%;"><div class="bar-label">JUL</div></div>
            <div class="bar bar-pale" style="height: 50%;"><div class="bar-label">AUG</div></div>
            <div class="bar bar-pale" style="height: 60%;"><div class="bar-label">SEP</div></div>
            <div class="bar bar-dark" style="height: 80%;"><div class="bar-label">OCT</div></div>
            <div class="bar bar-forecast" style="height: 90%;"><div class="bar-label">NOV</div></div>
        </div>
    </div>
    
    <div>
        <div class="section-header">
            <div class="section-title">Velocity Rankings</div>
        </div>
        <table class="velocity-table">
            <thead>
                <tr>
                    <th>RANK</th>
                    <th>ITEM NAME</th>
                    <th style="text-align: right;">TOTAL</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="rank-num">01</td>
                    <td>
                        <div class="item-name">Wagyu Ribeye</div>
                        <div class="item-cat">MAIN COURSE</div>
                    </td>
                    <td class="item-total">1,482</td>
                </tr>
                <tr>
                    <td class="rank-num">02</td>
                    <td>
                        <div class="item-name">Black Truffle Risotto</div>
                        <div class="item-cat">ENTRÉE</div>
                    </td>
                    <td class="item-total">1,240</td>
                </tr>
                <tr>
                    <td class="rank-num">03</td>
                    <td>
                        <div class="item-name">Heritage Carrots</div>
                        <div class="item-cat">SIDE</div>
                    </td>
                    <td class="item-total">985</td>
                </tr>
                <tr>
                    <td class="rank-num">04</td>
                    <td>
                        <div class="item-name">Oyster Selection</div>
                        <div class="item-cat">APPETIZER</div>
                    </td>
                    <td class="item-total">874</td>
                </tr>
            </tbody>
        </table>
        
        <div class="note-box">
            <strong>Note:</strong> Wagyu Ribeye demand is projected to increase by 15% next month due to the autumn menu campaign. Recommend increasing supplier orders by Oct 30.
        </div>
    </div>
</div>

<div class="bottom-footer">
    <div class="footer-brand">
        The Culinary<br>Editorial
    </div>
    <div class="footer-copy">
        © 2024 THE CULINARY EDITORIAL. ESTABLISHED IN EXCELLENCE.
    </div>
    <div class="footer-links">
        <a href="#">PRIVACY POLICY</a>
        <a href="#">TERMS OF SERVICE</a>
        <a href="#">PRESS KIT</a>
        <a href="#">CONTACT US</a>
    </div>
</div>

<jsp:include page="../../components/admin-footer.jsp" />
