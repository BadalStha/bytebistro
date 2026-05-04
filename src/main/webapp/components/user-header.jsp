<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>ByteBistro | Restaurant</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Georgia', serif;
            background: #f5f5dc;
        }

        /* Top Navigation Bar */
        nav {
            background: white;
            border-bottom: 1px solid #ddd;
            padding: 16px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: #3d0000;
        }

        .logo h2 {
            font-size: 16px;
            font-weight: bold;
        }

        .logo p {
            font-size: 10px;
            color: #888;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            gap: 24px;
            flex: 1;
            justify-content: center;
        }

        .nav-links a {
            color: #666;
            text-decoration: none;
            font-size: 12px;
            letter-spacing: 1px;
            transition: 0.3s;
            text-transform: uppercase;
        }

        .nav-links a:hover {
            color: #8b0000;
        }

        .nav-links a.active {
            color: #8b0000;
            font-weight: bold;
            border-bottom: 2px solid #8b0000;
            padding-bottom: 4px;
        }

        .nav-right {
            display: flex;
            gap: 16px;
            align-items: center;
        }

        .user-name {
            font-size: 12px;
            color: #666;
        }

        .btn-auth {
            background: #8b0000;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 11px;
            letter-spacing: 1px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-auth:hover {
            background: #6b0000;
        }

        /* Main container */
        .container {
            padding: 32px 40px;
            min-height: calc(100vh - 80px);
        }
    </style>
</head>

<body>

<!-- Top Navigation Bar -->
<nav>
    <a href="<%= request.getContextPath() %>/" class="logo">
        <h2>ByteBistro</h2>
    </a>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/">HOME</a>
        <a href="<%= request.getContextPath() %>/pages/common/menu-view.jsp">MENU</a>
        <a href="<%= request.getContextPath() %>/pages/member/booking-form.jsp">BOOKING</a>
        <a href="<%= request.getContextPath() %>/pages/common/about.jsp">ABOUT</a>
        <a href="<%= request.getContextPath() %>/pages/common/contact.jsp">CONTACT</a>
    </div>

    <div class="nav-right">
        <%
            Object userObj = session.getAttribute("user");
            if (userObj != null) {
        %>
        <span class="user-name">Welcome back!</span>
        <a href="<%= request.getContextPath() %>/logout" class="btn-auth">LOGOUT</a>
        <%
        } else {
        %>
        <a href="<%= request.getContextPath() %>/pages/common/login.jsp" class="btn-auth">SIGN IN</a>
        <%
            }
        %>
    </div>
</nav>

<!-- Main Container -->
<div class="container">