<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ByteBistro | Premium Restaurant</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=DM+Sans:wght@300;400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --bb-bg:          #0f0f0f;
            --bb-surface:     #1a1a1a;
            --bb-surface-2:   #242424;
            --bb-border:      #2e2e2e;
            --bb-accent:      #e8a045;
            --bb-accent-soft: #e8a04522;
            --bb-text:        #f0ece4;
            --bb-text-muted:  #7a7570;
            --bb-success:     #4caf7d;
            --bb-danger:      #e05c5c;
            --bb-info:        #5b9bd5;
            --bb-radius:      10px;
            --bb-radius-lg:   18px;
            --bb-shadow:      0 4px 24px rgba(0,0,0,0.45);
            --bb-font-display: 'Playfair Display', Georgia, serif;
            --bb-font-body:    'DM Sans', system-ui, sans-serif;
            --bb-font-mono:    'JetBrains Mono', monospace;
        }

        /* Reset & Base */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            background: var(--bb-bg); 
            color: var(--bb-text); 
            font-family: var(--bb-font-body); 
            min-height: 100vh; 
            display: flex;
            overflow-x: hidden;
        }

        /* Layout */
        .bb-app { display: flex; min-height: 100vh; width: 100%; }
        
        .bb-sidebar { 
            width: 240px; 
            background: var(--bb-surface); 
            border-right: 1px solid var(--bb-border); 
            display: flex; 
            flex-direction: column; 
            position: fixed; 
            top: 0; 
            left: 0; 
            height: 100vh; 
            padding: 24px 0; 
            z-index: 100; 
        }
        
        .bb-main-wrap { 
            margin-left: 240px; 
            flex: 1; 
            display: flex; 
            flex-direction: column; 
            min-width: 0;
        }
        
        .bb-main { 
            padding: 32px; 
            flex: 1; 
            animation: bbFadeIn 0.3s ease both;
        }

        /* Logo */
        .bb-logo { 
            display: flex; 
            align-items: center; 
            gap: 12px; 
            padding: 0 24px 28px; 
            border-bottom: 1px solid var(--bb-border); 
            text-decoration: none;
        }
        .bb-logo-icon { font-size: 1.5rem; }
        .bb-logo-text { 
            font-family: var(--bb-font-display); 
            font-size: 1.3rem; 
            color: var(--bb-accent); 
            font-weight: 700;
        }

        /* Nav */
        .bb-nav { padding: 24px 12px; flex: 1; display: flex; flex-direction: column; gap: 6px; }
        .bb-nav-item { 
            display: flex; 
            align-items: center; 
            gap: 12px; 
            padding: 12px 16px; 
            border-radius: var(--bb-radius); 
            color: var(--bb-text-muted); 
            text-decoration: none; 
            font-size: 0.9rem; 
            font-weight: 500; 
            transition: all 0.2s ease; 
        }
        .bb-nav-item:hover, .bb-nav-item.active { 
            background: var(--bb-accent-soft); 
            color: var(--bb-accent); 
        }
        .bb-nav-item i { width: 20px; text-align: center; font-size: 1rem; }
        
        .bb-sidebar-footer { padding: 12px; border-top: 1px solid var(--bb-border); }
        .bb-nav-item--logout:hover { background: #e05c5c22; color: var(--bb-danger); }

        /* Shared Page Styles */
        .bb-page-header { margin-bottom: 32px; }
        .bb-page-title { font-family: var(--bb-font-display); font-size: 2.2rem; font-weight: 700; color: var(--bb-text); }
        .bb-page-sub { color: var(--bb-text-muted); font-size: 0.95rem; margin-top: 6px; }

        .bb-card { 
            background: var(--bb-surface); 
            border: 1px solid var(--bb-border); 
            border-radius: var(--bb-radius-lg); 
            padding: 28px; 
            margin-bottom: 24px; 
        }
        .bb-card-title { font-family: var(--bb-font-display); font-size: 1.25rem; font-weight: 600; color: var(--bb-accent); margin-bottom: 24px; }

        .bb-table-wrap { overflow-x: auto; border-radius: var(--bb-radius); border: 1px solid var(--bb-border); background: var(--bb-surface); }
        .bb-table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
        .bb-table th { 
            padding: 16px; text-align: left; font-size: 0.75rem; text-transform: uppercase; 
            letter-spacing: 0.1em; color: var(--bb-text-muted); font-weight: 600; border-bottom: 1px solid var(--bb-border);
        }
        .bb-table td { padding: 16px; border-top: 1px solid var(--bb-border); color: var(--bb-text); }

        .bb-btn { 
            display: inline-flex; align-items: center; justify-content: center; gap: 8px; padding: 10px 24px; 
            border-radius: var(--bb-radius); font-size: 0.9rem; font-weight: 600; cursor: pointer; border: none; 
            text-decoration: none; transition: all 0.2s ease; 
        }
        .bb-btn--primary { background: var(--bb-accent); color: #0f0f0f; }
        .bb-btn--outline { background: transparent; border: 1px solid var(--bb-border); color: var(--bb-text); }
        .bb-btn--outline:hover { border-color: var(--bb-accent); color: var(--bb-accent); background: var(--bb-accent-soft); }

        .bb-input { 
            width: 100%; padding: 12px 16px; background: var(--bb-surface-2); border: 1px solid var(--bb-border); 
            border-radius: var(--bb-radius); color: var(--bb-text); font-family: var(--bb-font-body); font-size: 0.95rem; transition: all 0.2s; 
        }
        .bb-input:focus { outline: none; border-color: var(--bb-accent); box-shadow: 0 0 0 3px var(--bb-accent-soft); }

        .bb-label { display: block; font-size: 0.85rem; font-weight: 600; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 8px; }

        /* Dashboard Stats */
        .bb-stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 24px; margin-bottom: 32px; }
        .bb-stat-card { 
            background: var(--bb-surface); border: 1px solid var(--bb-border); border-radius: var(--bb-radius-lg); 
            padding: 24px; display: flex; align-items: center; gap: 20px; transition: 0.3s;
        }
        .bb-stat-card:hover { border-color: var(--bb-accent); transform: translateY(-4px); }
        .bb-stat-icon { 
            width: 54px; height: 54px; background: var(--bb-accent-soft); color: var(--bb-accent); 
            border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; 
        }
        .bb-stat-value { font-family: var(--bb-font-display); font-size: 1.75rem; font-weight: 700; color: #fff; line-height: 1; }
        .bb-stat-label { font-size: 0.8rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-top: 4px; }

        /* Badges & States */
        .bb-badge { padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; }
        .bb-badge--served { background: rgba(76, 175, 125, 0.1); color: var(--bb-success); }
        .bb-badge--pending { background: rgba(232, 160, 69, 0.1); color: var(--bb-accent); }
        .bb-badge--cancelled { background: rgba(224, 92, 92, 0.1); color: var(--bb-danger); }
        .bb-badge--info { background: rgba(91, 155, 213, 0.1); color: var(--bb-info); }
        .bb-empty-state { padding: 48px; text-align: center; color: var(--bb-text-muted); font-size: 0.9rem; }
        .bb-empty-state i { display: block; font-size: 2.5rem; margin-bottom: 16px; opacity: 0.3; }

        .bb-divider { height: 1px; background: var(--bb-border); margin: 12px 16px; }

        @keyframes bbFadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: none; } }
    </style>
</head>
<body>

<div class="bb-app">
    <!-- Sidebar Navigation -->
    <aside class="bb-sidebar">
        <a href="${pageContext.request.contextPath}/" class="bb-logo">
            <span class="bb-logo-icon">🍽️</span>
            <span class="bb-logo-text">ByteBistro</span>
        </a>

        <nav class="bb-nav">
            <a href="${pageContext.request.contextPath}/" class="bb-nav-item ${pageContext.request.requestURI.endsWith('/') ? 'active' : ''}">
                <i class="fa-solid fa-house"></i> Home
            </a>
            <a href="${pageContext.request.contextPath}/menu" class="bb-nav-item ${pageContext.request.requestURI.contains('menu') ? 'active' : ''}">
                <i class="fa-solid fa-utensils"></i> View Menu
            </a>
            <a href="${not empty sessionScope.userId ? pageContext.request.contextPath.concat('/booking') : pageContext.request.contextPath.concat('/pages/common/register.jsp')}" class="bb-nav-item ${pageContext.request.requestURI.contains('booking') ? 'active' : ''}">
                <i class="fa-solid fa-calendar-check"></i> Book a Table
            </a>
            
            <c:if test="${not empty sessionScope.userId}">
                <div class="bb-divider"></div>
                <a href="${pageContext.request.contextPath}/pages/member/dashboard.jsp" class="bb-nav-item ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                    <i class="fa-solid fa-gauge-high"></i> My Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/pages/member/order-history.jsp" class="bb-nav-item ${pageContext.request.requestURI.contains('order-history') ? 'active' : ''}">
                    <i class="fa-solid fa-clock-rotate-left"></i> Order History
                </a>
                <a href="${pageContext.request.contextPath}/pages/member/profile.jsp" class="bb-nav-item ${pageContext.request.requestURI.contains('profile') ? 'active' : ''}">
                    <i class="fa-solid fa-circle-user"></i> Profile
                </a>
            </c:if>
        </nav>

        <div class="bb-sidebar-footer">
            <c:choose>
                <c:when test="${not empty sessionScope.userId}">
                    <a href="${pageContext.request.contextPath}/logout" class="bb-nav-item bb-nav-item--logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </c:when>
                <c:otherwise>
                    <div style="display: flex; gap: 8px; padding: 0 4px;">
                        <a href="${pageContext.request.contextPath}/pages/common/login.jsp" class="bb-nav-item" style="flex: 1; padding: 12px 8px; justify-content: center; font-size: 0.85rem; gap: 8px;">
                            <i class="fa-solid fa-right-to-bracket" style="font-size: 0.9rem;"></i> Sign In
                        </a>
                        <a href="${pageContext.request.contextPath}/pages/common/register.jsp" class="bb-nav-item" style="flex: 1; padding: 12px 8px; justify-content: center; font-size: 0.85rem; gap: 8px; background: var(--bb-accent-soft); color: var(--bb-accent);">
                            <i class="fa-solid fa-user-plus" style="font-size: 0.9rem;"></i> Sign Up
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </aside>

    <div class="bb-main-wrap">
        <main class="bb-main">