<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ByteBistro</title>
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
        .register-card {
            display: flex;
            width: 1020px;
            max-width: 95%;
            background: #fff;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }

        /* ── Left Image Panel ── */
        .image-panel {
            width: 45%;
            min-height: 600px;
            background-image: url('https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=800');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: flex-end;
            padding: 40px;
        }

        .image-panel::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(
                    to top,
                    rgba(0,0,0,0.65) 0%,
                    rgba(0,0,0,0.1) 60%
            );
        }

        .image-quote {
            position: relative;
            z-index: 1;
        }

        .image-quote p {
            color: #fff;
            font-style: italic;
            font-size: 22px;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .quote-line {
            width: 40px;
            height: 2px;
            background: #c8a96e;
        }

        /* ── Right Form Panel ── */
        .form-panel {
            width: 55%;
            padding: 50px 55px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-panel h2 {
            font-size: 36px;
            color: #8B0000;
            font-weight: 700;
            margin-bottom: 6px;
            font-family: 'Georgia', serif;
        }

        .form-panel .subtitle {
            font-size: 11px;
            letter-spacing: 2px;
            color: #888;
            text-transform: uppercase;
            margin-bottom: 32px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 10px 14px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 18px;
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
            margin-bottom: 20px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #555;
            margin-bottom: 8px;
            font-family: 'Arial', sans-serif;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 14px;
            color: #333;
            background: #fff;
            outline: none;
            transition: border-color 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #8B0000;
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23888' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
        }

        /* ── Password Wrapper ── */
        .input-wrapper {
            position: relative;
        }

        .input-wrapper input {
            padding-right: 40px;
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
            font-size: 16px;
            user-select: none;
        }

        .toggle-password:hover {
            color: #8B0000;
        }

        /* ── Submit Button ── */
        .btn-register {
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

        .btn-register:hover {
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

        /* ── Page Footer ── */
        .page-footer {
            margin-top: 30px;
            text-align: center;
        }

        .page-footer .brand {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-style: italic;
            color: #8B0000;
            font-weight: 700;
        }

        .page-footer p {
            font-size: 11px;
            letter-spacing: 1.5px;
            color: #999;
            text-transform: uppercase;
            margin-top: 4px;
            font-family: 'Arial', sans-serif;
        }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .register-card {
                flex-direction: column;
            }

            .image-panel {
                width: 100%;
                min-height: 220px;
            }

            .form-panel {
                width: 100%;
                padding: 30px 24px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="register-card">

    <!-- Left Image Panel -->
    <div class="image-panel">
        <div class="image-quote">
            <p>"The table is set for a new chapter in culinary excellence."</p>
            <div class="quote-line"></div>
        </div>
    </div>

    <!-- Right Form Panel -->
    <div class="form-panel">

        <h2>Create Your Profile</h2>
        <p class="subtitle">Join the inner circle of the digital Ma&icirc;tre D&apos;</p>

        <%-- Error Message --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Success Message --%>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post" novalidate>

            <%-- Full Name --%>
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        placeholder=""
                        value="<%= request.getAttribute("fullName") != null
                                ? request.getAttribute("fullName") : "" %>"
                        required
                />
            </div>

            <%-- Email + Phone Row --%>
            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            value="<%= request.getAttribute("email") != null
                                    ? request.getAttribute("email") : "" %>"
                            required
                    />
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input
                            type="text"
                            id="phone"
                            name="phone"
                            value="<%= request.getAttribute("phone") != null
                                    ? request.getAttribute("phone") : "" %>"
                            required
                    />
                </div>
            </div>

            <%-- Password + Confirm Password Row --%>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
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
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrapper">
                        <input
                                type="password"
                                id="confirmPassword"
                                name="confirmPassword"
                                required
                        />
                        <span class="toggle-password"
                              onclick="togglePassword('confirmPassword')">&#128065;</span>
                    </div>
                </div>
            </div>

            <%-- Submit --%>
            <button type="submit" class="btn-register">Register</button>

            <%-- Login Link --%>
            <div class="form-footer-link">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">Login</a>
            </div>

        </form>
    </div>
</div>

<!-- Page Footer -->
<div class="page-footer">
    <div class="brand">ByteBistro</div>
    <p>&copy; 2024 ByteBistro. A Culinary Editorial Experience.</p>
</div>

<script>
    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        field.type = field.type === 'password' ? 'text' : 'password';
    }

    document.querySelector('form').addEventListener('submit', function(e) {
        const fullName = document.getElementById('fullName').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const role = document.getElementById('role').value;

        if (!/^[a-zA-Z ]+$/.test(fullName)) {
            alert('Full name must contain only letters.');
            e.preventDefault(); return;
        }
        if (!/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault(); return;
        }
        if (!/^\d{10,15}$/.test(phone)) {
            alert('Phone must be 10-15 digits only.');
            e.preventDefault(); return;
        }
        if (password.length < 6) {
            alert('Password must be at least 6 characters.');
            e.preventDefault(); return;
        }
        if (password !== confirmPassword) {
            alert('Passwords do not match.');
            e.preventDefault(); return;
        }
        if (!role) {
            alert('Please select a role.');
            e.preventDefault(); return;
        }
    });
</script>

</body>
</html>