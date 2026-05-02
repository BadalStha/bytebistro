<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ByteBistro</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f5f5dc;
            font-family: 'Georgia', serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        /* ── Main Card ── */
        .login-card {
            width: 480px;
            max-width: 95%;
            background: #fff;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            border-top: 4px solid #8B0000;
        }

        .card-body {
            padding: 48px 52px;
        }

        /* ── Header ── */
        .card-body h2 {
            font-size: 34px;
            color: #8B0000;
            font-weight: 700;
            text-align: center;
            margin-bottom: 8px;
            font-family: 'Georgia', serif;
        }

        .card-body .subtitle {
            font-size: 14px;
            color: #888;
            text-align: center;
            margin-bottom: 36px;
            font-family: 'Arial', sans-serif;
        }

        /* ── Alerts ── */
        .alert {
            padding: 10px 14px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 18px;
            font-family: 'Arial', sans-serif;
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

        /* ── Form Groups ── */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .form-group label {
            display: block;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #555;
            font-family: 'Arial', sans-serif;
        }

        .forgot-link {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
            text-decoration: none;
            font-family: 'Arial', sans-serif;
            transition: color 0.2s;
        }

        .forgot-link:hover {
            color: #8B0000;
        }

        /* REPLACE with this */
        .input-wrapper {
            display: flex;
            align-items: center;
            border: 1.5px solid #ddd;
            border-radius: 6px;
            padding: 10px 14px;
            transition: border-color 0.2s;
            background: #fff;
        }

        .input-wrapper:focus-within {
            border-color: #8B0000;
        }

        .input-icon {
            font-size: 16px;
            margin-right: 10px;
            color: #aaa;
        }

        /* REPLACE with this */
        .input-wrapper input {
            flex: 1;
            border: none;
            outline: none;
            font-size: 15px;
            color: #333;
            background: transparent;
            font-family: 'Arial', sans-serif;
        }

        .input-wrapper input::placeholder {
            color: #bbb;
        }

        .toggle-password {
            cursor: pointer;
            color: #aaa;
            font-size: 16px;
            user-select: none;
            margin-left: 8px;
            transition: color 0.2s;
        }

        .toggle-password:hover {
            color: #8B0000;
        }

        /* ── Submit Button ── */
        .btn-login {
            width: 100%;
            padding: 15px;
            background: #8B0000;
            color: #fff;
            border: none;
            border-radius: 3px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 8px;
            font-family: 'Arial', sans-serif;
        }

        .btn-login:hover {
            background: #6b0000;
        }

        /* ── Footer Link ── */
        .form-footer-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #666;
            font-family: 'Arial', sans-serif;
        }

        .form-footer-link a {
            color: #8B0000;
            text-decoration: none;
            font-weight: 600;
        }

        .form-footer-link a:hover {
            text-decoration: underline;
        }

        /* ── Security Badges ── */
        .security-badges {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 16px;
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }

        .badge {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #999;
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .badge-dot {
            width: 4px;
            height: 4px;
            background: #ccc;
            border-radius: 50%;
        }

        /* ── Responsive ── */
        @media (max-width: 520px) {
            .card-body {
                padding: 36px 24px;
            }

            .card-body h2 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="card-body">

        <!-- Header -->
        <h2>Welcome Back</h2>
        <p class="subtitle">Access your culinary dashboard</p>

        <%-- Error from servlet --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Error from URL parameter (filter redirect) --%>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getParameter("error") %>
        </div>
        <% } %>

        <%-- Success from URL parameter --%>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login"
              method="post" novalidate>

            <%-- Email --%>
            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-wrapper">
                    <span class="input-icon">&#9993;</span>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            value="<%= request.getAttribute("email") != null
                                    ? request.getAttribute("email") : "" %>"
                            required
                    />
                </div>
            </div>

            <%-- Password --%>
            <div class="form-group">
                <div class="form-group-header">
                    <label for="password">Password</label>
                    <a href="#" class="forgot-link">Forgot?</a>
                </div>
                <div class="input-wrapper">
                    <span class="input-icon">&#128274;</span>
                    <input
                            type="password"
                            id="password"
                            name="password"
                            required
                    />
                    <span class="toggle-password"
                          onclick="togglePassword('password')">&#128065;</span>
                </div>
            </div>

            <%-- Submit --%>
            <button type="submit" class="btn-login">
                Sign In To Portal
            </button>

            <%-- Register Link --%>
            <div class="form-footer-link">
                New to the kitchen?
                <a href="${pageContext.request.contextPath}/register">
                    Create an account
                </a>
            </div>

        </form>

        <!-- Security Badges -->
        <div class="security-badges">
            <span class="badge">&#9679; Secure Access</span>
            <span class="badge-dot"></span>
            <span class="badge">&#128274; 256-Bit Encrypted</span>
        </div>

    </div>
</div>

<script>
    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        field.type = field.type === 'password' ? 'text' : 'password';
    }

    document.querySelector('form').addEventListener('submit', function(e) {
        const email    = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!email || !password) {
            alert('Please fill in all fields.');
            e.preventDefault();
            return;
        }

        if (!/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault();
            return;
        }
    });
</script>

</body>
</html>