<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order - ByteBistro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
</head>
<body>

<%@ include file="/pages/common/navbar.jsp" %>

<div class="form-wrapper">
    <div class="form-card">

        <div class="form-header">
            <h2>Place Your Order</h2>
            <p>Select your favourite items and we will deliver to your door</p>
        </div>

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

        <form action="${pageContext.request.contextPath}/order" method="post" novalidate>

            <%-- Delivery Address --%>
            <div class="form-group">
                <label for="deliveryAddress">Delivery Address</label>
                <textarea
                        id="deliveryAddress"
                        name="deliveryAddress"
                        placeholder="Enter your full delivery address"
                        rows="3"
                        required
                ><%= request.getAttribute("deliveryAddress") != null ? request.getAttribute("deliveryAddress") : "" %></textarea>
            </div>

            <%-- Menu Items --%>
            <div class="form-group">
                <label>Select Items</label>

                <%
                    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
                    if (menuItems != null && !menuItems.isEmpty()) {
                %>
                <div class="menu-items-grid">
                    <% for (MenuItem item : menuItems) { %>
                    <div class="menu-item-card">
                        <div class="menu-item-info">
                            <h4><%= item.getName() %></h4>
                            <p class="item-type"><%= item.getItemType() %></p>
                            <p class="item-description"><%= item.getDescription() != null ? item.getDescription() : "" %></p>
                            <p class="item-price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>
                        </div>
                        <div class="menu-item-quantity">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>"/>
                            <label>Qty</label>
                            <input
                                    type="number"
                                    name="quantity"
                                    value="0"
                                    min="0"
                                    max="20"
                                    class="quantity-input"
                                    onchange="updateTotal()"
                                    data-price="<%= item.getPrice() %>"
                            />
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } else { %>
                <div class="alert alert-error">
                    No menu items available at the moment.
                </div>
                <% } %>
            </div>

            <%-- Order Summary --%>
            <div class="order-summary">
                <h3>Order Summary</h3>
                <div class="summary-row">
                    <span>Total Amount:</span>
                    <span id="totalAmount">Rs. 0.00</span>
                </div>
            </div>

            <%-- Submit --%>
            <div class="form-group">
                <button type="submit" class="btn-primary">Place Order</button>
                <a href="${pageContext.request.contextPath}/order?action=history"
                   class="btn-secondary">View Order History</a>
            </div>

        </form>
    </div>
</div>

<%@ include file="/pages/common/footer.jsp" %>

<script>
    // Calculate and update total amount
    function updateTotal() {
        const quantityInputs = document.querySelectorAll('.quantity-input');
        let total = 0;

        quantityInputs.forEach(function(input) {
            const quantity = parseInt(input.value) || 0;
            const price    = parseFloat(input.getAttribute('data-price')) || 0;
            total += quantity * price;
        });

        document.getElementById('totalAmount').textContent =
            'Rs. ' + total.toFixed(2);
    }

    // Client-side validation before submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const deliveryAddress = document.getElementById('deliveryAddress').value.trim();
        const quantityInputs  = document.querySelectorAll('.quantity-input');

        // Check delivery address
        if (!deliveryAddress) {
            alert('Please enter your delivery address.');
            e.preventDefault();
            return;
        }

        // Check at least one item selected
        let totalQuantity = 0;
        quantityInputs.forEach(function(input) {
            totalQuantity += parseInt(input.value) || 0;
        });

        if (totalQuantity === 0) {
            alert('Please select at least one item.');
            e.preventDefault();
            return;
        }
    });
</script>

</body>
</html>