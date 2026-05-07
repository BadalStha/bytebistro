<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.bytebistro.user.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - ByteBistro</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f5f5dc;
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
        }

        /* ── Navbar ── */
        .navbar {
            background: #fff;
            padding: 14px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #8B0000;
            font-style: italic;
            text-decoration: none;
        }

        .navbar-links {
            display: flex;
            gap: 32px;
            list-style: none;
        }

        .navbar-links a {
            text-decoration: none;
            color: #444;
            font-size: 14px;
            transition: color 0.2s;
        }

        .navbar-links a:hover,
        .navbar-links a.active {
            color: #8B0000;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 2px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .navbar-icon {
            font-size: 18px;
            color: #666;
            cursor: pointer;
            transition: color 0.2s;
        }

        .navbar-icon:hover {
            color: #8B0000;
        }

        .user-avatar-nav {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #8B0000;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        /* ── Main Layout ── */
        .main-layout {
            display: flex;
            gap: 28px;
            max-width: 1100px;
            margin: 0 auto;
            padding: 40px 24px;
            align-items: flex-start;
        }

        /* ── Left Sidebar ── */
        .left-sidebar {
            width: 320px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* ── Profile Card ── */
        .profile-card {
            background: #fff;
            border-radius: 8px;
            padding: 36px 28px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .avatar-circle {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #8B0000;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: 700;
            font-family: 'Georgia', serif;
            margin-bottom: 20px;
            border: 4px solid #f5f5dc;
            box-shadow: 0 4px 16px rgba(139,0,0,0.2);
        }

        .profile-name {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 6px;
        }

        .profile-role {
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 28px;
        }

        .profile-details {
            width: 100%;
            text-align: left;
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 28px;
        }

        .detail-item label {
            display: block;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #aaa;
            margin-bottom: 4px;
        }

        .detail-item p {
            font-size: 14px;
            color: #333;
            font-weight: 500;
        }

        .divider {
            width: 100%;
            height: 1px;
            background: #f0f0f0;
            margin: 4px 0;
        }

        .btn-signout {
            display: flex;
            align-items: center;
            gap: 8px;
            background: none;
            border: none;
            color: #888;
            font-size: 13px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            font-family: 'Arial', sans-serif;
            transition: color 0.2s;
            text-decoration: none;
            padding: 8px 0;
        }

        .btn-signout:hover {
            color: #8B0000;
        }

        /* ── Stats Card ── */
        .stats-card {
            background: #fff;
            border-radius: 8px;
            padding: 28px;
            text-align: center;
        }

        .stats-number {
            font-family: 'Georgia', serif;
            font-size: 48px;
            font-weight: 700;
            color: #8B0000;
            margin-bottom: 6px;
        }

        .stats-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
        }

        /* ── Right Panel ── */
        .right-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* ── Edit Profile Section ── */
        .edit-section {
            background: #f5f5dc;
        }

        .edit-header {
            margin-bottom: 28px;
        }

        .edit-header h1 {
            font-family: 'Georgia', serif;
            font-size: 38px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 10px;
            font-style: italic;
        }

        .edit-header p {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            max-width: 520px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #fdf0f0;
            color: #8B0000;
            border-left: 3px solid #8B0000;
        }

        .alert-success {
            background: #f0fdf4;
            color: #166534;
            border-left: 3px solid #166534;
        }

        /* ── Form Card ── */
        .form-card {
            background: #fff;
            border-radius: 8px;
            padding: 32px;
        }

        .form-card h3 {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f0f0f0;
        }

        /* ── Form Rows ── */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            font-family: 'Arial', sans-serif;
        }

        .form-group input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #e8e8e8;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background: #fafafa;
            outline: none;
            transition: border-color 0.2s, background 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .form-group input:focus {
            border-color: #8B0000;
            background: #fff;
        }

        .form-group input::placeholder {
            color: #ccc;
            letter-spacing: 2px;
        }

        /* ── Form Actions ── */
        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
        }

        .btn-discard {
            background: none;
            border: none;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            cursor: pointer;
            font-family: 'Arial', sans-serif;
            transition: color 0.2s;
            text-decoration: none;
        }

        .btn-discard:hover {
            color: #8B0000;
        }

        .btn-save {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #8B0000;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 14px 28px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .btn-save:hover {
            background: #6b0000;
        }

        /* ── Bottom Info Cards ── */
        .info-cards-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 16px;
        }

        .preferred-table-card {
            border-radius: 8px;
            overflow: hidden;
            height: 160px;
            background: linear-gradient(
                    135deg,
                    rgba(58,26,26,0.7) 0%,
                    rgba(100,60,40,0.5) 100%
            ),
            url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600')
            center/cover;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 20px;
        }

        .preferred-table-card .card-label {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-style: italic;
            color: #fff;
            margin-bottom: 4px;
        }

        .preferred-table-card .card-sublabel {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.7);
        }

        .vip-card {
            background: #c8a96e;
            border-radius: 8px;
            height: 160px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            padding: 24px;
            gap: 8px;
        }

        .vip-icon {
            font-size: 24px;
            margin-bottom: 4px;
        }

        .vip-title {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-weight: 700;
            color: #3a1a1a;
        }

        .vip-subtitle {
            font-size: 10px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: rgba(58,26,26,0.7);
        }

        /* ── Footer ── */
        .page-footer {
            padding: 32px 40px;
            border-top: 1px solid #e8e8d0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-top: 20px;
        }

        .footer-brand {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-style: italic;
            color: #8B0000;
            font-weight: 700;
        }

        .footer-copy {
            font-size: 11px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #aaa;
            margin-top: 4px;
        }

        .footer-links {
            display: flex;
            gap: 24px;
            list-style: none;
        }

        .footer-links a {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: #8B0000;
        }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .main-layout {
                flex-direction: column;
            }

            .left-sidebar {
                width: 100%;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .info-cards-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    String fullName = (user != null) ? user.getFullName() : "";
    String email    = (user != null) ? user.getEmail() : "";
    String phone    = (user != null) ? user.getPhone() : "";
    String role     = (user != null) ? user.getRole() : "member";
    String createdAt = (user != null && user.getCreatedAt() != null)
            ? user.getCreatedAt().toString().substring(0, 7) : "";
    String initial  = (!fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/"
       class="navbar-brand">ByteBistro</a>
    <ul class="navbar-links">
        <li>
            <a href="${pageContext.request.contextPath}/booking">
                Reservations</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">
                Menu</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order">
                Orders</a>
        </li>
    </ul>
    <div class="navbar-right">
        <span class="navbar-icon">&#128276;</span>
        <span class="navbar-icon">&#9881;</span>
        <div class="user-avatar-nav"><%= initial %></div>
    </div>
</nav>

<!-- Main Layout -->
<div class="main-layout">

    <!-- Left Sidebar -->
    <div class="left-sidebar">

        <!-- Profile Card -->
        <div class="profile-card">
            <div class="avatar-circle"><%= initial %></div>
            <p class="profile-name"><%= fullName %></p>
            <p class="profile-role"><%= role.toUpperCase() %></p>

            <div class="profile-details">
                <div class="detail-item">
                    <label>Email Address</label>
                    <p><%= email %></p>
                </div>
                <div class="divider"></div>
                <div class="detail-item">
                    <label>Phone Number</label>
                    <p><%= phone %></p>
                </div>
                <div class="divider"></div>
                <div class="detail-item">
                    <label>Member Since</label>
                    <p><%= createdAt %></p>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/logout"
               class="btn-signout">
                &#x2192; Sign Out
            </a>
        </div>

        <!-- Stats Card -->
        <div class="stats-card">
            <p class="stats-number">0</p>
            <p class="stats-label">Reservations Made</p>
        </div>

    </div>

    <!-- Right Panel -->
    <div class="right-panel">

        <!-- Edit Header -->
        <div class="edit-header">
            <h1>Edit Profile</h1>
            <p>Update your personal details and account security
                settings. These changes will be reflected across
                the ByteBistro editorial platform.</p>
        </div>

        <%-- Alerts --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <!-- Update Profile Form -->
        <div class="form-card">
            <h3>Personal Information</h3>
            <form action="${pageContext.request.contextPath}/profile"
                  method="post" novalidate>
                <input type="hidden" name="action" value="updateProfile"/>

                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input
                                type="text"
                                id="fullName"
                                name="fullName"
                                value="<%= fullName %>"
                                required
                        />
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input
                                type="text"
                                id="phone"
                                name="phone"
                                value="<%= phone %>"
                                required
                        />
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/profile"
                       class="btn-discard">Discard Changes</a>
                    <button type="submit" class="btn-save">
                        Save Changes &#10003;
                    </button>
                </div>
            </form>
        </div>

        <!-- Change Password Form -->
        <div class="form-card">
            <h3>Change Password</h3>
            <form action="${pageContext.request.contextPath}/profile"
                  method="post" novalidate>
                <input type="hidden" name="action" value="changePassword"/>

                <div class="form-row">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input
                                type="password"
                                id="currentPassword"
                                name="currentPassword"
                                placeholder="••••••••"
                        />
                    </div>
                    <div class="form-group">
                        <%-- empty col for spacing --%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input
                                type="password"
                                id="newPassword"
                                name="newPassword"
                                placeholder="••••••••"
                        />
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="••••••••"
                        />
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/profile"
                       class="btn-discard">Discard Changes</a>
                    <button type="submit" class="btn-save">
                        Save Changes &#10003;
                    </button>
                </div>
            </form>
        </div>

        <!-- Bottom Info Cards -->
        <div class="info-cards-row">
            <div class="preferred-table-card">
                <p class="card-label">Preferred Table</p>
                <p class="card-sublabel">Corner Booth, Window View</p>
            </div>
            <div class="vip-card">
                <div class="vip-icon">&#127860;</div>
                <p class="vip-title">VIP Status</p>
                <p class="vip-subtitle">Michelin Management Certified</p>
            </div>
        </div>

    </div>
</div>

<!-- Footer -->
<footer class="page-footer">
    <div>
        <p class="footer-brand">ByteBistro</p>
        <p class="footer-copy">
            &copy; 2024 ByteBistro Editorial. All Rights Reserved.
        </p>
    </div>
    <ul class="footer-links">
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
        <li><a href="#">Contact Support</a></li>
        <li><a href="#">Global Press</a></li>
    </ul>
</footer>

<script>
    // Client-side validation for profile update
    document.querySelectorAll('form').forEach(function(form) {
        form.addEventListener('submit', function(e) {
            var action = form.querySelector('[name="action"]').value;

            if (action === 'updateProfile') {
                var fullName = form.querySelector('#fullName').value.trim();
                var phone    = form.querySelector('#phone').value.trim();

                if (!fullName || !phone) {
                    alert('Full name and phone are required.');
                    e.preventDefault(); return;
                }
                if (!/^[a-zA-Z ]+$/.test(fullName)) {
                    alert('Full name must contain only letters.');
                    e.preventDefault(); return;
                }
                if (!/^\d{10,15}$/.test(phone)) {
                    alert('Phone must be 10-15 digits only.');
                    e.preventDefault(); return;
                }
            }

            if (action === 'changePassword') {
                var current = form.querySelector('#currentPassword').value;
                var newPass  = form.querySelector('#newPassword').value;
                var confirm  = form.querySelector('#confirmPassword').value;

                if (!current || !newPass || !confirm) {
                    alert('All password fields are required.');
                    e.preventDefault(); return;
                }
                if (newPass.length < 6) {
                    alert('New password must be at least 6 characters.');
                    e.preventDefault(); return;
                }
                if (newPass !== confirm) {
                    alert('New passwords do not match.');
                    e.preventDefault(); return;
                }
            }
        });
    });
</script>

</body>
</html>