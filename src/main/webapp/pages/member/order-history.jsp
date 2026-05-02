<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.order.model.Order" %>
<%@ page import="com.bytebistro.order.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - ByteBistro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
</head>
<body>

<%@ include file="/pages/common/navbar.jsp" %>

<div class="container">

    <div class="page-header">
        <h2>My Order History</h2>
        <a href="${pageContext.request.contextPath}/order"
           class="btn-primary">Place New Order</a>
    </div>

    <%-- Success Message --%>
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <%-- Error Message --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
    <div class="orders-list">
        <% for (Order order : orders) { %>
        <div class="order-card">

            <%-- Order Header --%>
            <div class="order-card-header">
                <div class="order-info">
                    <h3>Order #<%= order.getOrderId() %></h3>
                    <p class="order-date">
                        Placed on: <%= order.getOrderedAt() %>
                    </p>
                    <p class="order-address">
                        <strong>Delivery Address:</strong>
                        <%= order.getDeliveryAddress() %>
                    </p>
                </div>
                <div class="order-status">
                                <span class="status-badge status-<%= order.getStatus() %>">
                                    <%= order.getStatus().toUpperCase() %>
                                </span>
                    <p class="order-total">
                        Total: <strong>Rs. <%= String.format("%.2f", order.getTotalAmount()) %></strong>
                    </p>
                </div>
            </div>

            <%-- Order Items --%>
            <div class="order-items">
                <table class="items-table">
                    <thead>
                    <tr>
                        <th>Item</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<OrderItem> items = order.getOrderItems();
                        if (items != null && !items.isEmpty()) {
                            for (OrderItem item : items) {
                    %>
                    <tr>
                        <td><%= item.getItemName() %></td>
                        <td>Rs. <%= String.format("%.2f", item.getUnitPrice()) %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>Rs. <%= String.format("%.2f", item.getTotalPrice()) %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="4">No items found for this order.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <%-- Cancel Button (only for pending orders) --%>
            <% if ("pending".equals(order.getStatus())) { %>
            <div class="order-card-footer">
                <form action="${pageContext.request.contextPath}/order"
                      method="post">
                    <input type="hidden" name="action" value="cancel"/>
                    <input type="hidden" name="orderId"
                           value="<%= order.getOrderId() %>"/>
                    <button type="submit" class="btn-danger"
                            onclick="return confirm('Are you sure you want to cancel this order?')">
                        Cancel Order
                    </button>
                </form>
            </div>
            <% } %>

        </div>
        <% } %>
    </div>

    <% } else { %>
    <div class="empty-state">
        <h3>No orders found</h3>
        <p>You have not placed any orders yet.</p>
        <a href="${pageContext.request.contextPath}/order"
           class="btn-primary">Place Your First Order</a>
    </div>
    <% } %>

</div>

<%@ include file="/pages/common/footer.jsp" %>

</body>
</html>