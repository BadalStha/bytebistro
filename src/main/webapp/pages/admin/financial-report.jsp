<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../components/admin-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <div style="display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 class="bb-page-title">Financial Performance</h1>
            <p class="bb-page-sub">Analyze revenue trends, order volume, and fiscal health indicators.</p>
        </div>
        <div style="display: flex; gap: 12px; align-items: center;">
            <div style="background: var(--bb-surface-2); padding: 10px 20px; border-radius: var(--bb-radius); border: 1px solid var(--bb-border);">
                <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 2px;">Reporting Period</div>
                <div style="font-size: 0.9rem; font-weight: 600; color: var(--bb-accent);">Oct 01 - Oct 31, 2023 <i class="fa-solid fa-calendar-days" style="margin-left: 8px;"></i></div>
            </div>
            <button class="bb-btn bb-btn--outline" style="width: 48px; height: 48px; padding: 0; display: flex; align-items: center; justify-content: center;">
                <i class="fa-solid fa-sliders"></i>
            </button>
        </div>
    </div>
</div>

<!-- Section: Key Performance Indicators -->
<div class="bb-stats-grid">
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-money-bill-trend-up"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">Rs. 124,850</div>
            <div class="bb-stat-label">Gross Revenue</div>
            <div style="font-size: 0.75rem; color: var(--bb-success); margin-top: 8px;">
                <i class="fa-solid fa-arrow-trend-up"></i> +12.4% vs prev. month
            </div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-receipt"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">1,482</div>
            <div class="bb-stat-label">Total Orders</div>
            <div style="font-size: 0.75rem; color: var(--bb-text-muted); margin-top: 8px;">
                <i class="fa-solid fa-minus"></i> Stable traffic
            </div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon"><i class="fa-solid fa-chart-line"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value">Rs. 84.25</div>
            <div class="bb-stat-label">Avg Order Value</div>
            <div style="font-size: 0.75rem; color: var(--bb-success); margin-top: 8px;">
                <i class="fa-solid fa-arrow-trend-up"></i> +5.2% increase
            </div>
        </div>
    </div>
    <div class="bb-stat-card">
        <div class="bb-stat-icon" style="color: var(--bb-danger);"><i class="fa-solid fa-tag"></i></div>
        <div class="bb-stat-body">
            <div class="bb-stat-value" style="color: var(--bb-danger);">Rs. 3,120</div>
            <div class="bb-stat-label">Marketing Discounts</div>
            <div style="font-size: 0.75rem; color: var(--bb-danger); margin-top: 8px;">
                <i class="fa-solid fa-arrow-trend-down"></i> 2.5% revenue impact
            </div>
        </div>
    </div>
</div>

<div style="display: grid; grid-template-columns: 2fr 1fr; gap: 32px; margin-bottom: 40px;">
    <!-- Revenue Chart Area -->
    <div class="bb-card">
        <div class="bb-card-header">
            <h3 class="bb-card-title">Revenue Trajectory</h3>
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em;">
                <span style="display: inline-block; width: 8px; height: 8px; background: var(--bb-accent); border-radius: 50%; margin-right: 6px;"></span> Gross Monthly Revenue
            </div>
        </div>
        
        <div style="height: 300px; display: flex; align-items: flex-end; justify-content: space-between; padding: 40px 20px 20px; position: relative; border-bottom: 1px solid var(--bb-border);">
            <div style="width: 40px; background: var(--bb-surface-2); border-radius: 4px 4px 0 0; height: 30%; position: relative;">
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-text-muted); font-weight: 600;">MAY</span>
            </div>
            <div style="width: 40px; background: var(--bb-surface-2); border-radius: 4px 4px 0 0; height: 45%; position: relative;">
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-text-muted); font-weight: 600;">JUN</span>
            </div>
            <div style="width: 40px; background: var(--bb-surface-2); border-radius: 4px 4px 0 0; height: 40%; position: relative;">
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-text-muted); font-weight: 600;">JUL</span>
            </div>
            <div style="width: 40px; background: var(--bb-surface-2); border-radius: 4px 4px 0 0; height: 55%; position: relative;">
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-text-muted); font-weight: 600;">AUG</span>
            </div>
            <div style="width: 40px; background: var(--bb-surface-2); border-radius: 4px 4px 0 0; height: 65%; position: relative;">
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-text-muted); font-weight: 600;">SEP</span>
            </div>
            <div style="width: 40px; background: var(--bb-accent); border-radius: 4px 4px 0 0; height: 85%; position: relative; box-shadow: 0 4px 20px rgba(232, 160, 69, 0.3);">
                <div style="position: absolute; top: -30px; left: 50%; transform: translateX(-50%); font-size: 0.75rem; background: var(--bb-surface-3); color: var(--bb-accent); padding: 4px 8px; border-radius: 4px; font-weight: bold; border: 1px solid var(--bb-accent);">Rs. 124k</div>
                <span style="position: absolute; bottom: -25px; left: 50%; transform: translateX(-50%); font-size: 0.7rem; color: var(--bb-accent); font-weight: 700;">OCT</span>
            </div>
        </div>
    </div>
    
    <!-- Insights Card -->
    <div class="bb-card" style="background: var(--bb-accent-soft); border-color: var(--bb-accent); display: flex; flex-direction: column; justify-content: space-between;">
        <div>
            <div style="font-size: 2rem; margin-bottom: 20px;">💡</div>
            <h3 style="font-family: var(--bb-font-display); font-size: 1.5rem; margin-bottom: 16px; font-style: italic; color: var(--bb-accent);">Maître d' Insights</h3>
            <p style="font-size: 1rem; color: var(--bb-text); line-height: 1.7; opacity: 0.9;">
                Revenue peaks on <strong>Saturdays between 19:00 and 21:30</strong>. 
                Introducing a premium 'Late Night Tasting' menu could capitalize on this surge.
            </p>
        </div>
        <button class="bb-btn bb-btn--primary" style="margin-top: 32px;">
            <i class="fa-solid fa-wand-magic-sparkles"></i> Generate Full Analysis
        </button>
    </div>
</div>

<!-- Section: Transaction Log -->
<div class="bb-card">
    <div class="bb-card-header">
        <h3 class="bb-card-title">Recent Transactions</h3>
        <a href="#" style="font-size: 0.75rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.1em; text-decoration: none; font-weight: 600;">
            <i class="fa-solid fa-file-export"></i> Export Ledger
        </a>
    </div>
    
    <div class="bb-table-wrap">
        <table class="bb-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Items Purchased</th>
                    <th>Total Amount</th>
                    <th>Timestamp</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="bb-mono" style="font-size: 0.8rem; color: var(--bb-text-muted);">#BB-10294</td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 12px; font-weight: 600;">
                            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=40&h=40&q=80" 
                                 style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;" alt="User">
                            Julian Montgomery
                        </div>
                    </td>
                    <td style="color: var(--bb-text-muted); font-size: 0.85rem;">4 Course Tasting Menu, Reserve Wine Pairing...</td>
                    <td style="font-weight: 700; color: var(--bb-accent);">Rs. 12,412</td>
                    <td style="font-size: 0.8rem; line-height: 1.4;">Oct 24, 2023<br><span style="opacity: 0.5;">20:15 IST</span></td>
                    <td><span class="bb-badge bb-badge--active">Settled</span></td>
                </tr>
                <tr>
                    <td class="bb-mono" style="font-size: 0.8rem; color: var(--bb-text-muted);">#BB-10293</td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 12px; font-weight: 600;">
                            <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=40&h=40&q=80" 
                                 style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;" alt="User">
                            Elena Vance
                        </div>
                    </td>
                    <td style="color: var(--bb-text-muted); font-size: 0.85rem;">Aged Wagyu Ribeye, Black Truffle Fries...</td>
                    <td style="font-weight: 700; color: var(--bb-accent);">Rs. 8,185</td>
                    <td style="font-size: 0.8rem; line-height: 1.4;">Oct 24, 2023<br><span style="opacity: 0.5;">19:42 IST</span></td>
                    <td><span class="bb-badge bb-badge--active">Settled</span></td>
                </tr>
                <tr>
                    <td class="bb-mono" style="font-size: 0.8rem; color: var(--bb-text-muted);">#BB-10292</td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 12px; font-weight: 600;">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=40&h=40&q=80" 
                                 style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;" alt="User">
                            Marcus Chen
                        </div>
                    </td>
                    <td style="color: var(--bb-text-muted); font-size: 0.85rem;">Grand Seafood Platter, Sancerre 2019...</td>
                    <td style="font-weight: 700; color: var(--bb-accent);">Rs. 15,294</td>
                    <td style="font-size: 0.8rem; line-height: 1.4;">Oct 24, 2023<br><span style="opacity: 0.5;">19:15 IST</span></td>
                    <td><span class="bb-badge bb-badge--pending">Authorized</span></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div style="text-align: center; margin-top: 32px;">
        <a href="#" style="font-size: 0.75rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.2em; text-decoration: none; font-weight: 700; transition: 0.2s;"
           onmouseover="this.style.color='var(--bb-accent)'" onmouseout="this.style.color='var(--bb-text-muted)'">
            Browse Full Transaction Ledger <i class="fa-solid fa-arrow-right" style="margin-left: 8px;"></i>
        </a>
    </div>
</div>

<div style="text-align: center; margin-top: 80px; padding-top: 40px; border-top: 1px solid var(--bb-border); opacity: 0.5;">
    <div style="display: flex; justify-content: center; gap: 32px; margin-bottom: 16px;">
        <a href="#" style="font-size: 0.7rem; color: var(--bb-text); text-decoration: none; text-transform: uppercase; letter-spacing: 0.1em; font-weight: 600;">Data Privacy</a>
        <a href="#" style="font-size: 0.7rem; color: var(--bb-text); text-decoration: none; text-transform: uppercase; letter-spacing: 0.1em; font-weight: 600;">Audit Logs</a>
        <a href="#" style="font-size: 0.7rem; color: var(--bb-text); text-decoration: none; text-transform: uppercase; letter-spacing: 0.1em; font-weight: 600;">Support</a>
    </div>
    <p style="font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.15em;">© 2024 BYTEBISTRO OPERATIONS. PROPRIETARY DATA.</p>
</div>

<jsp:include page="../../components/admin-footer.jsp" />

