<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ByteBistro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
</head>
<body>

<%@ include file="/pages/common/navbar.jsp" %>

<div class="form-wrapper">
    <div class="form-card">

        <div class="form-header">
            <h2>Welcome Back</h2>
            <p>Login to your ByteBistro account</p>
        </div>

        <%-- Error Message --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <%-- Error from URL parameter (from filter redirect) --%>
        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getParameter("error") %>
        </div>
        <% } %>

        <%-- Success Message (from registration or logout) --%>
        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <%-- Success from URL parameter --%>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post" novalidate>

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

            <%-- Password --%>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            required
                    />
                    <span class="toggle-password" onclick="togglePassword('password')">&#128065;</span>
                </div>
            </div>

            <%-- Submit --%>
            <div class="form-group">
                <button type="submit" class="btn-primary">Login</button>
            </div>

            <%-- Register Link --%>
            <div class="form-footer">
                <p>Don't have an account?
                    <a href="${pageContext.request.contextPath}/register">Register here</a>
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
        const email    = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();

        // Check empty fields
        if (!email || !password) {
            alert('Please fill in all fields.');
            e.preventDefault();
            return;
        }

        // Email format
        if (!/^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$/.test(email)) {
            alert('Please enter a valid email address.');
            e.preventDefault();
            return;
        }
    });
</script>

</body>
</html>