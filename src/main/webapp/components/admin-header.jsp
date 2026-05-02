<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>ByteBistro | Admin Panel</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Georgia', serif;
            background: #f5f5dc;
        }

        /* Sidebar Navigation */
        nav {
            width: 220px;
            background: #f0f0c8;
            border-right: 1px solid #ddd;
            display: flex;
            flex-direction: column;
            padding: 24px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .logo {
            padding: 0 24px 32px;
            border-bottom: 1px solid #ddd;
        }

        .logo h2 {
            font-size: 18px;
            color: #3d0000;
            font-weight: bold;
        }

        .logo p {
            font-size: 10px;
            color: #888;
            letter-spacing: 1px;
            margin-top: 4px;
        }

        .links {
            display: flex;
            flex-direction: column;
            padding: 16px 0;
            flex: 1;
        }

        .links a {
            color: #666;
            text-decoration: none;
            padding: 12px 24px;
            font-size: 12px;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: 0.3s;
        }

        .links a:hover {
            background: #e8e8b0;
            color: #3d0000;
        }

        .links a.active {
            background: #e8e8b0;
            color: #3d0000;
            font-weight: bold;
            border-left: 3px solid #8b0000;
        }

        .nav-bottom {
            padding-top: 16px;
            border-top: 1px solid #ddd;
        }

        /* Main container */
        .main-container {
            margin-left: 220px;
            padding: 0;
        }

        .container {
            padding: 32px 40px;
            min-height: 100vh;
        }
    </style>
</head>

<body>

<!-- Sidebar Navigation -->
<nav>
    <div class="logo">
        <h2>ByteBistro</h2>
    </div>

    <div class="links">
        <a href="<%= request.getContextPath() %>/admin/dashboard">DASHBOARD</a>
        <a href="<%= request.getContextPath() %>/admin/menu?page=list" class="<%= request.getRequestURI().contains("/menu") ? "active" : "" %>">MENU</a>
        <a href="<%= request.getContextPath() %>/admin/promotion">PROMOTIONS</a>
        <a href="<%= request.getContextPath() %>/admin/report">FINANCIAL REPORT</a>
        <a href="<%= request.getContextPath() %>/admin/analytics">ANALYTICS</a>
    </div>

    <div class="links nav-bottom">
        <a href="#">SUPPORT</a>
        <a href="<%= request.getContextPath() %>/logout">LOG OUT</a>
    </div>
</nav>

<!-- Main Container -->
<div class="main-container">
    <div class="container">