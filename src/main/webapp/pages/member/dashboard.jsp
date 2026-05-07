<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Member Dashboard</title></head>
<body>
<h2>Welcome, <%= session.getAttribute("fullName") %></h2>
<a href="${pageContext.request.contextPath}/order">Place Order</a> |
<a href="${pageContext.request.contextPath}/order?action=history">Order History</a> |
<a href="${pageContext.request.contextPath}/booking">Book Table</a> |
<a href="${pageContext.request.contextPath}/rating">Rate Us</a> |
<a href="${pageContext.request.contextPath}/logout">Logout</a>
</body>
</html>