<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | ByteBistro Culinary Editorial</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
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
            --bb-danger:      #e05c5c;
            --bb-radius:      10px;
            --bb-font-display: 'Playfair Display', Georgia, serif;
            --bb-font-body:    'DM Sans', system-ui, sans-serif;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            background: var(--bb-bg); 
            color: var(--bb-text); 
            font-family: var(--bb-font-body); 
            min-height: 100vh;
            display: flex;
            overflow: hidden;
        }

        .auth-container { display: flex; width: 100%; min-height: 100vh; }
        
        .auth-image { 
            flex: 1.2; 
            background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.8)), 
                        url('https://images.unsplash.com/photo-1559339352-11d035aa65de?auto=format&fit=crop&w=1200&q=80');
            background-size: cover;
            background-position: center;
            background-color: var(--bb-surface);
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 60px;
            position: relative;
        }
        
        .auth-image::after {
            content: '';
            position: absolute;
            top: 60px;
            left: 60px;
            width: 40px;
            height: 2px;
            background: var(--bb-accent);
        }

        .auth-quote {
            max-width: 500px;
            animation: bbFadeUp 1s ease both;
        }
        .auth-quote h2 {
            font-family: var(--bb-font-display);
            font-size: 3rem;
            line-height: 1.1;
            margin-bottom: 24px;
            font-style: italic;
        }
        .auth-quote p {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.7);
            line-height: 1.6;
        }

        .auth-form-wrap {
            flex: 1;
            background: var(--bb-bg);
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 80px;
            position: relative;
        }

        .auth-header { margin-bottom: 48px; }
        .auth-logo { 
            display: inline-flex; 
            align-items: center; 
            gap: 12px; 
            text-decoration: none; 
            margin-bottom: 40px; 
        }
        .auth-logo-text { 
            font-family: var(--bb-font-display); 
            font-size: 1.5rem; 
            color: var(--bb-accent); 
            font-weight: 700; 
        }

        .auth-title { font-family: var(--bb-font-display); font-size: 2.5rem; margin-bottom: 12px; }
        .auth-sub { color: var(--bb-text-muted); font-size: 0.95rem; }

        .bb-form-group { margin-bottom: 24px; }
        .bb-label { 
            display: block; 
            font-size: 0.75rem; 
            font-weight: 700; 
            color: var(--bb-text-muted); 
            text-transform: uppercase; 
            letter-spacing: 0.15em; 
            margin-bottom: 10px; 
        }
        .bb-input { 
            width: 100%; padding: 14px 18px; 
            background: var(--bb-surface); 
            border: 1px solid var(--bb-border); 
            border-radius: var(--bb-radius); 
            color: var(--bb-text); 
            font-size: 1rem; 
            transition: 0.3s; 
        }
        .bb-input:focus { outline: none; border-color: var(--bb-accent); background: var(--bb-surface-2); }

        .bb-btn { 
            width: 100%; padding: 16px; 
            background: var(--bb-accent); 
            color: #0f0f0f; 
            border: none; 
            border-radius: var(--bb-radius); 
            font-size: 1rem; 
            font-weight: 700; 
            cursor: pointer; 
            transition: 0.3s; 
            margin-top: 12px;
        }
        .bb-btn:hover { background: #ffb55e; transform: translateY(-2px); }

        .bb-alert {
            padding: 14px 18px;
            border-radius: var(--bb-radius);
            font-size: 0.9rem;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .bb-alert--danger { background: rgba(224, 92, 92, 0.1); color: var(--bb-danger); border: 1px solid rgba(224, 92, 92, 0.2); }
        .bb-alert--success { background: rgba(76, 175, 125, 0.1); color: #4caf7d; border: 1px solid rgba(76, 175, 125, 0.2); }

        .auth-footer { 
            margin-top: 40px; 
            text-align: center; 
            font-size: 0.9rem; 
            color: var(--bb-text-muted); 
        }
        .auth-footer a { color: var(--bb-accent); text-decoration: none; font-weight: 600; }

        @keyframes bbFadeUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: none; } }

        @media (max-width: 1024px) {
            .auth-image { display: none; }
            .auth-form-wrap { padding: 40px; }
        }
    </style>
</head>
<body>

<div class="auth-container">
    <!-- Left: Editorial Content -->
    <div class="auth-image">
        <div class="auth-quote">
            <h2>The Table<br>Is Set.</h2>
            <p>Access your personalized culinary dashboard and manage your exclusive member privileges.</p>
        </div>
    </div>

    <!-- Right: Authentication Form -->
    <div class="auth-form-wrap">
        <div class="auth-header">
            <a href="${pageContext.request.contextPath}/" class="auth-logo">
                <span style="font-size: 1.5rem;">🍽️</span>
                <span class="auth-logo-text">ByteBistro</span>
            </a>
            <h1 class="auth-title">Welcome <span style="font-style: italic; color: var(--bb-accent);">Back</span></h1>
            <p class="auth-sub">Please enter your credentials to access the editorial.</p>
        </div>

        <%-- Alerts --%>
        <c:if test="${not empty requestScope.error}">
            <div class="bb-alert bb-alert--danger">
                <i class="fa-solid fa-circle-exclamation"></i>
                ${requestScope.error}
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="bb-alert bb-alert--danger">
                <i class="fa-solid fa-circle-exclamation"></i>
                ${param.error}
            </div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div class="bb-alert bb-alert--success">
                <i class="fa-solid fa-circle-check"></i>
                ${param.success}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
            <div class="bb-form-group">
                <label class="bb-label" for="email">Email</label>
                <input type="email" id="email" name="email" class="bb-input" 
                       placeholder="badal@gmail.com"
                       value="${not empty requestScope.email ? requestScope.email : ''}" required />
            </div>

            <div class="bb-form-group">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                    <label class="bb-label" for="password" style="margin-bottom: 0;">Password</label>
                    <a href="#" style="font-size: 0.75rem; color: var(--bb-accent); text-decoration: none; font-weight: 600;">Forgot?</a>
                </div>
                <div style="position: relative;">
                    <input type="password" id="password" name="password" class="bb-input" placeholder="••••••••" required />
                    <button type="button" onclick="togglePassword()" style="position: absolute; right: 16px; top: 50%; transform: translateY(-50%); background: none; border: none; color: var(--bb-text-muted); cursor: pointer;">
                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="bb-btn">Sign In To Portal</button>
        </form>

        <div class="auth-footer">
            New to the kitchen? <a href="${pageContext.request.contextPath}/pages/common/register.jsp">Create an account</a>
        </div>
        
        <div style="margin-top: 60px; padding-top: 32px; border-top: 1px solid var(--bb-border); display: flex; gap: 24px; justify-content: center;">
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; display: flex; align-items: center; gap: 8px;">
                <i class="fa-solid fa-shield-halved" style="color: var(--bb-accent);"></i> Secure Access
            </div>
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; display: flex; align-items: center; gap: 8px;">
                <i class="fa-solid fa-lock" style="color: var(--bb-accent);"></i> 256-bit Encrypted
            </div>
        </div>
    </div>
</div>

<script>
    function togglePassword() {
        const pass = document.getElementById('password');
        const icon = document.getElementById('eyeIcon');
        if (pass.type === 'password') {
            pass.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            pass.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const email = document.getElementById('email').value.trim();
        const pass = document.getElementById('password').value.trim();
        
        if (!email || !pass) {
            alert('Please provide your identity credentials.');
            e.preventDefault();
        }
    });
</script>

</body>
</html>