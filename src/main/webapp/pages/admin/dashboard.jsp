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
        --text-dark: #222;
    }

    body {
        background-color: var(--bg-beige);
        color: var(--dark-red);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    h1, h2, h3, h4, .serif-font {
        font-family: 'Georgia', serif;
    }

    .dash-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;
    }

    .dash-title h1 {
        font-size: 36px;
        font-weight: bold;
        color: var(--dark-red);
        margin-bottom: 8px;
    }

    .dash-title p {
        font-size: 14px;
        color: var(--text-grey);
    }

    .dash-actions {
        display: flex;
        gap: 16px;
    }

    .btn-secondary {
        background-color: var(--accent-pale);
        color: var(--dark-red);
        padding: 12px 24px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 1px;
        cursor: pointer;
        text-transform: uppercase;
        transition: 0.3s;
    }

    .btn-secondary:hover {
        background-color: #e8e8b0;
    }

    .btn-primary {
        background-color: var(--dark-red);
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 4px;
        font-size: 11px;
        font-weight: bold;
        letter-spacing: 1px;
        cursor: pointer;
        text-transform: uppercase;
        transition: 0.3s;
    }

    .btn-primary:hover {
        background-color: var(--primary-red);
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px;
        margin-bottom: 40px;
    }

    .stat-card {
        background: var(--card-white);
        border-radius: 8px;
        padding: 24px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        position: relative;
    }

    .stat-card .icon {
        width: 32px;
        height: 32px;
        background: #fdf2e9;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 24px;
        color: var(--dark-red);
    }

    .stat-card .trend {
        position: absolute;
        top: 24px;
        right: 24px;
        font-size: 11px;
        font-weight: bold;
    }
    .trend.positive { color: #2e7d32; }

    .stat-label {
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        margin-bottom: 8px;
    }

    .stat-value {
        font-size: 32px;
        font-family: 'Georgia', serif;
        font-weight: bold;
        color: var(--dark-red);
    }

    .banner {
        background: linear-gradient(rgba(61, 0, 0, 0.7), rgba(61, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=1600&q=80') center/cover;
        border-radius: 12px;
        padding: 60px 40px;
        color: white;
        margin-bottom: 40px;
    }

    .banner h2 {
        font-size: 36px;
        font-style: italic;
        margin-bottom: 16px;
    }

    .banner p {
        font-size: 16px;
        max-width: 500px;
        line-height: 1.5;
        opacity: 0.9;
    }

    .table-card {
        background: var(--card-white);
        border-radius: 12px;
        padding: 32px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }

    .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
    }

    .table-header h3 {
        font-size: 20px;
        font-weight: bold;
        color: var(--dark-red);
    }

    .view-all {
        font-size: 11px;
        font-weight: bold;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
        text-decoration: none;
    }

    .view-all:hover {
        color: var(--dark-red);
    }

    .data-table {
        width: 100%;
        border-collapse: collapse;
    }

    .data-table th {
        text-align: left;
        padding: 16px 0;
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        color: var(--text-grey);
        border-bottom: 1px solid #eee;
    }

    .data-table td {
        padding: 24px 0;
        border-bottom: 1px solid #eee;
        font-size: 14px;
        color: var(--text-dark);
    }

    .data-table tr:last-child td {
        border-bottom: none;
    }

    .badge-status {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 10px;
        font-weight: bold;
        text-transform: uppercase;
    }

    .badge-preparing { background: #fff3cd; color: #856404; }
    .badge-urgent { background: #f8d7da; color: #721c24; }
    .badge-delivered { background: #d4edda; color: #155724; }

    .action-icon {
        color: var(--dark-red);
        cursor: pointer;
        opacity: 0.7;
    }

    .action-icon:hover {
        opacity: 1;
    }

    .dash-footer {
        text-align: center;
        margin-top: 60px;
        padding-top: 40px;
        border-top: 1px solid #e0e0e0;
    }

    .dash-footer h4 {
        font-size: 18px;
        color: var(--dark-red);
        font-style: italic;
        margin-bottom: 16px;
    }

    .footer-links {
        display: flex;
        justify-content: center;
        gap: 24px;
        margin-bottom: 16px;
    }

    .footer-links a {
        font-size: 12px;
        color: var(--text-grey);
        text-decoration: none;
    }

    .footer-links a:hover {
        color: var(--dark-red);
    }

    .copyright {
        font-size: 11px;
        color: var(--text-grey);
    }
</style>

<div class="dash-header">
    <div class="dash-title">
        <h1>Welcome back, Admin James</h1>
        <p>Here is the pulse of ByteBistro for today.</p>
    </div>
    <div class="dash-actions">
        <button class="btn-secondary">ADD MENU ITEM</button>
        <button class="btn-primary">ADD PROMOTION</button>
    </div>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="icon">🛍️</div>
        <div class="trend positive">+12%</div>
        <div class="stat-label">TOTAL ORDERS</div>
        <div class="stat-value">1,284</div>
    </div>
    <div class="stat-card">
        <div class="icon">💵</div>
        <div class="trend positive">+8%</div>
        <div class="stat-label">REVENUE TODAY</div>
        <div class="stat-value">$14,320</div>
    </div>
    <div class="stat-card">
        <div class="icon">📢</div>
        <div class="stat-label">ACTIVE PROMOTIONS</div>
        <div class="stat-value">6</div>
    </div>
    <div class="stat-card">
        <div class="icon">📖</div>
        <div class="stat-label">MENU ITEMS</div>
        <div class="stat-value">42</div>
    </div>
</div>

<div class="banner">
    <h2>ByteBistro Editorial</h2>
    <p>Manage your culinary empire with grace and precision. Your evening reservations are up 24% this week.</p>
</div>

<div class="table-card">
    <div class="table-header">
        <h3>Recent Orders</h3>
        <a href="#" class="view-all">VIEW ALL ORDERS</a>
    </div>
    <table class="data-table">
        <thead>
            <tr>
                <th>ORDER ID</th>
                <th>CUSTOMER</th>
                <th>ADDRESS</th>
                <th>STATUS</th>
                <th>AMOUNT</th>
                <th>ACTION</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>#BB-2094</td>
                <td>Julianne Moore</td>
                <td style="font-style: italic; color: var(--text-grey);">122 West End Ave, NY</td>
                <td><span class="badge-status badge-preparing">PREPARING</span></td>
                <td style="font-weight: bold;">$124.50</td>
                <td><span class="action-icon">👁️</span></td>
            </tr>
            <tr>
                <td>#BB-2093</td>
                <td>Marcus Thorne</td>
                <td style="font-style: italic; color: var(--text-grey);">88 Greenwich St, NY</td>
                <td><span class="badge-status badge-urgent">URGENT</span></td>
                <td style="font-weight: bold;">$340.00</td>
                <td><span class="action-icon">👁️</span></td>
            </tr>
            <tr>
                <td>#BB-2092</td>
                <td>Sophia Loren</td>
                <td style="font-style: italic; color: var(--text-grey);">240 Central Park South</td>
                <td><span class="badge-status badge-delivered">DELIVERED</span></td>
                <td style="font-weight: bold;">$89.20</td>
                <td><span class="action-icon">👁️</span></td>
            </tr>
            <tr>
                <td>#BB-2091</td>
                <td>Alexander Ray</td>
                <td style="font-style: italic; color: var(--text-grey);">52 Bond Street, NY</td>
                <td><span class="badge-status badge-preparing">PREPARING</span></td>
                <td style="font-weight: bold;">$210.15</td>
                <td><span class="action-icon">👁️</span></td>
            </tr>
        </tbody>
    </table>
</div>

<div class="dash-footer">
    <h4>ByteBistro</h4>
    <div class="footer-links">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Contact Us</a>
        <a href="#">Careers</a>
    </div>
    <p class="copyright">© 2024 ByteBistro Editorial. All rights reserved.</p>
</div>

<jsp:include page="../../components/admin-footer.jsp" />
