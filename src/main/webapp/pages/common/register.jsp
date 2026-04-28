<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ByteBistro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
</head>
<body>

<%@ include file="/pages/common/navbar.jsp" %>

<div class="form-wrapper">
    <div class="form-card">

        <div class="form-header">
            <h2>Create Account</h2>
            <p>Join ByteBistro and enjoy exclusive features</p>
        </div>

        <%-- Error Message --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Success Message (redirected from another page) --%>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post" novalidate>

            <%-- Full Name --%>
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        placeholder="Enter your full name"
                        value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                        required
                />
            </div>

            <%-- Email --%>
            <div class="form-group">
                <label for="email">Email Address</label>
                <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                        required
                />
            </div>

            <%-- Phone --%>
            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input
                        type="text"
                        id="phone"
                        name="phone"
                        placeholder="Enter your phone number"
                        value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                        required
                />
            </div>

            <%-- Password --%>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Minimum 6 characters"
                            required
                    />
                    <span class="toggle-password" onclick="togglePassword('password')">&#128065;</span>
                </div>
            </div>

            <%-- Confirm Password --%>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-wrapper">
                    <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Re-enter your password"
                            required
                    />
                    <span class="toggle-password" onclick="togglePassword('confirmPassword')">&#128065;</span>
                </div>
            </div>

            <%-- Role --%>
            <div class="form-group">
                <label for="role">Register As</label>
                <select id="role" name="role" required>
                    <option value="" disabled
                            <%= request.getAttribute("role") == null ? "selected" : "" %>>
                        -- Select Role --
                    </option>
                    <option value="member"
                            <%= "member".equals(request.getAttribute("role")) ? "selected" : "" %>>
                        Member
                    </option>
                    <option value="visitor"
                            <%= "visitor".equals(request.getAttribute("role")) ? "selected" : "" %>>
                        Visitor
                    </option>
                </select>
            </div>

            <%-- Submit --%>
            <div class="form-group">
                <button type="submit" class="btn-primary">Create Account</button>
            </div>

            <%-- Login Link --%>
            <div class="form-footer">
                <p>Already have an account?
                    <a href="${pageContext.request.contextPath}/login">Login here</a>
                </p>
            </div>

        </form>
    </div>
</div>

<%@ include file="/pages/common/footer.jsp" %>

<script>
    // Toggle password visibility
    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        field.type = field.type === 'password' ? 'text' : 'password';
    }

    // Client-side validation before submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const fullName = document.getElementById('fullName').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const role = document.getElementById('role').value;

        // Name letters only
        if (!/^[a-zA-Z ]+$/.test(fullName)) {
            alert('Full name must contain only letters.');
            e.preventDefault();
            return;
        }

        // Email format
        if (!/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault();
            return;
        }

        // Phone digits only
        if (!/^\d{10,15}$/.test(phone)) {
            alert('Phone must be 10-15 digits only.');
            e.preventDefault();
            return;
        }

        // Password length
        if (password.length < 6) {
            alert('Password must be at least 6 characters.');
            e.preventDefault();
            return;
        }

        // Password match
        if (password !== confirmPassword) {
            alert('Passwords do not match.');
            e.preventDefault();
            return;
        }

        // Role selected
        if (!role) {
            alert('Please select a role.');
            e.preventDefault();
            return;
        }
    });
</script>

</body>
</html>