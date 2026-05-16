<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | ByteBistro Culinary Editorial</title>
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
            overflow-x: hidden;
        }

        .auth-container { display: flex; width: 100%; min-height: 100vh; }
        
        .auth-image { 
            flex: 1; 
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.9)), 
                        url('https://images.unsplash.com/photo-1543007630-9710e4a00a20?auto=format&fit=crop&w=1200&q=80');
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
            flex: 1.2;
            background: var(--bb-bg);
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px 80px;
            overflow-y: auto;
        }

        .auth-header { margin-bottom: 40px; }
        .auth-logo { 
            display: inline-flex; 
            align-items: center; 
            gap: 12px; 
            text-decoration: none; 
            margin-bottom: 32px; 
        }
        .auth-logo-text { 
            font-family: var(--bb-font-display); 
            font-size: 1.5rem; 
            color: var(--bb-accent); 
            font-weight: 700; 
        }

        .auth-title { font-family: var(--bb-font-display); font-size: 2.5rem; margin-bottom: 12px; }
        .auth-sub { color: var(--bb-text-muted); font-size: 0.95rem; }

        .bb-form-group { margin-bottom: 20px; }
        .bb-label { 
            display: block; 
            font-size: 0.7rem; 
            font-weight: 700; 
            color: var(--bb-text-muted); 
            text-transform: uppercase; 
            letter-spacing: 0.15em; 
            margin-bottom: 8px; 
        }
        .bb-input { 
            width: 100%; padding: 12px 16px; 
            background: var(--bb-surface); 
            border: 1px solid var(--bb-border); 
            border-radius: var(--bb-radius); 
            color: var(--bb-text); 
            font-size: 0.95rem; 
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
            margin-top: 24px;
        }
        .bb-btn:hover { background: #ffb55e; transform: translateY(-2px); }

        .bb-alert {
            padding: 14px 18px;
            border-radius: var(--bb-radius);
            font-size: 0.9rem;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .bb-alert--danger { background: rgba(224, 92, 92, 0.1); color: var(--bb-danger); border: 1px solid rgba(224, 92, 92, 0.2); }

        .auth-footer { 
            margin-top: 32px; 
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
            <h2>Join the<br>Inner Circle.</h2>
            <p>Experience priority reservations, bespoke events, and a curated culinary journey designed for the sophisticated palate.</p>
        </div>
    </div>

    <!-- Right: Registration Form -->
    <div class="auth-form-wrap">
        <div class="auth-header">
            <a href="${pageContext.request.contextPath}/" class="auth-logo">
                <span style="font-size: 1.5rem;">🍽️</span>
                <span class="auth-logo-text">ByteBistro</span>
            </a>
            <h1 class="auth-title">Create Your <span style="font-style: italic; color: var(--bb-accent);">Identity</span></h1>
            <p class="auth-sub">Enter your details to join our exclusive culinary community.</p>
        </div>

        <%-- Alerts --%>
        <c:if test="${not empty requestScope.error}">
            <div class="bb-alert bb-alert--danger">
                <i class="fa-solid fa-circle-exclamation"></i>
                ${requestScope.error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="bb-form-group">
                <label class="bb-label" for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="bb-input" 
                       placeholder="Badal Shrestha"
                       value="${not empty requestScope.fullName ? requestScope.fullName : ''}" required />
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="bb-form-group">
                    <label class="bb-label" for="email">Email</label>
                    <input type="email" id="email" name="email" class="bb-input" 
                           placeholder="badalshrestha@gmail.com"
                           value="${not empty requestScope.email ? requestScope.email : ''}" required />
                </div>
                <div class="bb-form-group">
                    <label class="bb-label" for="phone">Contact Number</label>
                    <input type="text" id="phone" name="phone" class="bb-input" 
                           placeholder="+977 9700000000"
                           value="${not empty requestScope.phone ? requestScope.phone : ''}" required />
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="bb-form-group">
                    <label class="bb-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="bb-input" placeholder="••••••••" required />
                </div>
                <div class="bb-form-group">
                    <label class="bb-label" for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="bb-input" placeholder="••••••••" required />
                </div>
            </div>

            <button type="submit" class="bb-btn">Join Now</button>
        </form>

        <div class="auth-footer">
            Already have an identity? <a href="${pageContext.request.contextPath}/pages/common/login.jsp">Sign in</a>
        </div>
        
        <div style="margin-top: 48px; padding-top: 24px; border-top: 1px solid var(--bb-border); text-align: center; font-size: 0.75rem; color: var(--bb-text-muted);">
            By joining, you agree to our <a href="#" style="color: var(--bb-text); text-decoration: underline;">Terms of Service</a> and <a href="#" style="color: var(--bb-text); text-decoration: underline;">Privacy Policy</a>.
        </div>
    </div>
</div>

<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const fullName = document.getElementById('fullName').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const pass = document.getElementById('password').value;
        const confirm = document.getElementById('confirmPassword').value;

        if (!/^[a-zA-Z ]+$/.test(fullName)) {
            alert('Full name must contain only standard letters.');
            e.preventDefault(); return;
        }
        if (!/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault(); return;
        }
        if (!/^\d{10,15}$/.test(phone.replace(/\D/g,''))) {
            alert('Phone must be 10-15 digits.');
            e.preventDefault(); return;
        }
        if (pass.length < 6) {
            alert('Security key must be at least 6 characters.');
            e.preventDefault(); return;
        }
        if (pass !== confirm) {
            alert('Security keys do not match.');
            e.preventDefault(); return;
        }
    });
</script>

</body>
</html>