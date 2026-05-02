<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order - ByteBistro</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f5f5dc;
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
        }

        /* ── Navbar ── */
        .navbar {
            background: #fff;
            padding: 14px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-family: 'Georgia', serif;
            font-size: 22px;
            font-weight: 700;
            color: #8B0000;
            font-style: italic;
            text-decoration: none;
        }

        .navbar-links {
            display: flex;
            gap: 32px;
            list-style: none;
        }

        .navbar-links a {
            text-decoration: none;
            color: #444;
            font-size: 14px;
            transition: color 0.2s;
        }

        .navbar-links a:hover,
        .navbar-links a.active {
            color: #8B0000;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 2px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .btn-new-booking {
            background: #8B0000;
            color: #fff;
            padding: 8px 18px;
            border-radius: 3px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
            text-decoration: none;
            text-transform: uppercase;
            transition: background 0.2s;
        }

        .btn-new-booking:hover {
            background: #6b0000;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #8B0000;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        /* ── Main Layout ── */
        .main-layout {
            display: flex;
            gap: 0;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px;
            align-items: flex-start;
        }

        /* ── Left Panel ── */
        .left-panel {
            flex: 1;
            padding-right: 40px;
        }

        .page-label {
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B0000;
            margin-bottom: 8px;
        }

        .page-title {
            font-family: 'Georgia', serif;
            font-size: 42px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 32px;
            line-height: 1.1;
        }

        /* ── Category Tabs ── */
        .category-tabs {
            display: flex;
            gap: 24px;
            margin-bottom: 28px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 0;
            flex-wrap: wrap;
        }

        .tab-btn {
            background: none;
            border: none;
            font-size: 14px;
            color: #888;
            cursor: pointer;
            padding-bottom: 10px;
            border-bottom: 2px solid transparent;
            transition: all 0.2s;
            font-family: 'Georgia', serif;
            white-space: nowrap;
        }

        .tab-btn.active {
            color: #1a1a1a;
            border-bottom: 2px solid #1a1a1a;
        }

        .tab-btn:hover {
            color: #1a1a1a;
        }

        /* ── Menu Grid ── */
        .menu-grid {
            display: none;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .menu-grid.active {
            display: grid;
        }

        /* ── Featured Item (first item larger) ── */
        .menu-item-featured {
            grid-column: span 1;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .menu-item-featured .item-image {
            height: 200px;
            background: #ddd;
            background-size: cover;
            background-position: center;
        }

        .menu-item-featured .item-body {
            padding: 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .menu-item-featured .item-name {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .menu-item-featured .item-price {
            font-size: 15px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .menu-item-featured .item-desc {
            font-size: 12px;
            color: #888;
            line-height: 1.5;
            flex: 1;
        }

        .btn-add-cart {
            background: none;
            border: 1px solid #1a1a1a;
            border-radius: 3px;
            padding: 8px 16px;
            font-size: 12px;
            cursor: pointer;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.2s;
            margin-top: 8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-family: 'Arial', sans-serif;
        }

        .btn-add-cart:hover {
            background: #1a1a1a;
            color: #fff;
        }

        /* ── Regular Menu Item ── */
        .menu-item-card {
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .menu-item-card .item-image {
            height: 140px;
            background: #ddd;
            background-size: cover;
            background-position: center;
        }

        .menu-item-card .item-body {
            padding: 12px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .menu-item-card .item-name {
            font-family: 'Georgia', serif;
            font-size: 15px;
            font-weight: 700;
            color: #1a1a1a;
        }

        .menu-item-card .item-tag {
            font-size: 10px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
        }

        .menu-item-card .item-desc {
            font-size: 11px;
            color: #888;
            line-height: 1.5;
            flex: 1;
        }

        .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
        }

        .menu-item-card .item-price {
            font-size: 14px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .btn-cart-icon {
            width: 32px;
            height: 32px;
            background: #8B0000;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            transition: background 0.2s;
        }

        .btn-cart-icon:hover {
            background: #6b0000;
        }

        /* ── Right Panel (Order Summary) ── */
        .right-panel {
            width: 300px;
            flex-shrink: 0;
            background: #f5f5dc;
            position: sticky;
            top: 80px;
        }

        .order-summary-card {
            background: #fff;
            border-radius: 8px;
            padding: 24px;
        }

        .order-summary-card h3 {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 20px;
        }

        /* ── Cart Items ── */
        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-bottom: 20px;
            min-height: 60px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cart-item-image {
            width: 48px;
            height: 48px;
            border-radius: 6px;
            background: #ddd;
            background-size: cover;
            background-position: center;
            flex-shrink: 0;
        }

        .cart-item-info {
            flex: 1;
        }

        .cart-item-name {
            font-size: 13px;
            font-weight: 600;
            color: #1a1a1a;
        }

        .cart-item-controls {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 4px;
        }

        .qty-btn {
            width: 22px;
            height: 22px;
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .qty-btn:hover {
            background: #8B0000;
            color: #fff;
            border-color: #8B0000;
        }

        .qty-display {
            font-size: 13px;
            font-weight: 600;
            min-width: 16px;
            text-align: center;
        }

        .cart-item-price {
            font-size: 13px;
            font-weight: 600;
            color: #1a1a1a;
            white-space: nowrap;
        }

        .btn-remove {
            background: none;
            border: none;
            cursor: pointer;
            color: #bbb;
            font-size: 16px;
            padding: 2px;
            transition: color 0.2s;
            align-self: flex-start;
        }

        .btn-remove:hover {
            color: #8B0000;
        }

        .empty-cart {
            font-size: 13px;
            color: #aaa;
            text-align: center;
            padding: 16px 0;
        }

        /* ── Delivery Address ── */
        .delivery-section {
            margin-bottom: 20px;
        }

        .delivery-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 8px;
            font-family: 'Arial', sans-serif;
        }

        .delivery-section textarea {
            width: 100%;
            border: 1px solid #eee;
            border-radius: 6px;
            padding: 10px 12px;
            font-size: 13px;
            color: #333;
            resize: none;
            outline: none;
            font-family: 'Arial', sans-serif;
            background: #fafafa;
            transition: border-color 0.2s;
        }

        .delivery-section textarea:focus {
            border-color: #8B0000;
        }

        /* ── Order Totals ── */
        .order-totals {
            border-top: 1px solid #f0f0f0;
            padding-top: 16px;
            margin-bottom: 16px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #666;
            margin-bottom: 8px;
        }

        .total-row.grand-total {
            font-size: 16px;
            font-weight: 700;
            color: #1a1a1a;
            margin-top: 12px;
            padding-top: 12px;
            border-top: 1px solid #eee;
        }

        /* ── Place Order Button ── */
        .btn-place-order {
            width: 100%;
            padding: 14px;
            background: #8B0000;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .btn-place-order:hover {
            background: #6b0000;
        }

        .delivery-estimate {
            text-align: center;
            font-size: 11px;
            color: #aaa;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-top: 10px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 10px 14px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 16px;
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

        /* ── Footer ── */
        .page-footer {
            background: #fff;
            padding: 32px 40px;
            margin-top: 60px;
            border-top: 1px solid #eee;
        }

        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
        }

        .footer-brand {
            font-family: 'Georgia', serif;
            font-size: 13px;
            color: #666;
        }

        .footer-links {
            display: flex;
            gap: 24px;
            list-style: none;
        }

        .footer-links a {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888;
            text-decoration: none;
            transition: color 0.2s;
        }

        .footer-links a:hover {
            color: #8B0000;
        }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .main-layout {
                flex-direction: column;
            }
            .left-panel {
                padding-right: 0;
            }
            .right-panel {
                width: 100%;
                position: static;
            }
            .menu-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">ByteBistro</a>
    <ul class="navbar-links">
        <li><a href="${pageContext.request.contextPath}/booking">Reservations</a></li>
        <li><a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">Menu</a></li>
        <li><a href="${pageContext.request.contextPath}/order" class="active">Orders</a></li>
    </ul>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/booking" class="btn-new-booking">
            New Booking
        </a>
        <div class="user-avatar"><%= initial %></div>
    </div>
</nav>

<!-- Main Layout -->
<div class="main-layout">

    <!-- Left Panel -->
    <div class="left-panel">

        <p class="page-label">Member Exclusive</p>
        <h1 class="page-title">Place an Order</h1>

        <%-- Alerts --%>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getParameter("success") %>
        </div>
        <% } %>

        <%
            List<MenuItem> menuItems =
                    (List<MenuItem>) request.getAttribute("menuItems");

            // Group items by type
            java.util.Map<String, List<MenuItem>> grouped = new java.util.LinkedHashMap<>();
            if (menuItems != null) {
                for (MenuItem item : menuItems) {
                    String type = item.getItemType();
                    if (!grouped.containsKey(type)) {
                        grouped.put(type, new java.util.ArrayList<>());
                    }
                    grouped.get(type).add(item);
                }
            }
            String[] types = grouped.keySet().toArray(new String[0]);
        %>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <% for (int t = 0; t < types.length; t++) { %>
            <button class="tab-btn <%= t == 0 ? "active" : "" %>"
                    onclick="switchTab('<%= types[t].replaceAll("\\s+", "_") %>', this)">
                <%= types[t] %>
            </button>
            <% } %>
        </div>

        <!-- Menu Grids per Category -->
        <% for (int t = 0; t < types.length; t++) {
            String type = types[t];
            String typeId = type.replaceAll("\\s+", "_");
            List<MenuItem> typeItems = grouped.get(type);
        %>
        <div class="menu-grid <%= t == 0 ? "active" : "" %>"
             id="grid_<%= typeId %>">
            <% for (int i = 0; i < typeItems.size(); i++) {
                MenuItem item = typeItems.get(i);
            %>
            <% if (i == 0) { %>
            <!-- Featured Item -->
            <div class="menu-item-featured">
                <div class="item-image"
                     style="background-color: #c8a96e;"></div>
                <div class="item-body">
                    <div style="display:flex;
                                                justify-content:space-between;
                                                align-items:flex-start;">
                                        <span class="item-name">
                                            <%= item.getName() %>
                                        </span>
                        <span class="item-price">
                                            Rs.<%= String.format("%.2f",
                                item.getPrice()) %>
                                        </span>
                    </div>
                    <p class="item-desc">
                        <%= item.getDescription() != null
                                ? item.getDescription() : "" %>
                    </p>
                    <button class="btn-add-cart"
                            onclick="addToCart(
                                <%= item.getItemId() %>,
                                    '<%= item.getName()
                                                    .replace("'", "\\'") %>',
                                <%= item.getPrice() %>)">
                        + Add to Cart
                    </button>
                </div>
            </div>
            <% } else { %>
            <!-- Regular Item -->
            <div class="menu-item-card">
                <div class="item-image"
                     style="background-color: #e8d5b0;"></div>
                <div class="item-body">
                    <p class="item-name"><%= item.getName() %></p>
                    <p class="item-tag">
                        <%= item.getItemType().toUpperCase() %>
                    </p>
                    <p class="item-desc">
                        <%= item.getDescription() != null
                                ? item.getDescription() : "" %>
                    </p>
                    <div class="item-footer">
                                        <span class="item-price">
                                            Rs.<%= String.format("%.2f",
                                                item.getPrice()) %>
                                        </span>
                        <button class="btn-cart-icon"
                                onclick="addToCart(
                                    <%= item.getItemId() %>,
                                        '<%= item.getName()
                                                        .replace("'", "\\'") %>',
                                    <%= item.getPrice() %>)">
                            &#128722;
                        </button>
                    </div>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
        <% } %>

    </div>

    <!-- Right Panel: Order Summary -->
    <div class="right-panel">
        <div class="order-summary-card">
            <h3>Your Order</h3>

            <!-- Cart Items Display -->
            <div class="cart-items" id="cartItems">
                <p class="empty-cart">No items added yet.</p>
            </div>

            <!-- Delivery Address -->
            <div class="delivery-section">
                <p class="delivery-label">Delivery Address</p>
                <textarea id="deliveryAddress" name="deliveryAddress"
                          rows="3"
                          placeholder="123 Gastronomy Lane, Suite 402...">
                    </textarea>
            </div>

            <!-- Order Totals -->
            <div class="order-totals">
                <div class="total-row">
                    <span>Subtotal</span>
                    <span id="subtotalDisplay">Rs. 0.00</span>
                </div>
                <div class="total-row">
                    <span>Service Fee</span>
                    <span id="serviceFeeDisplay">Rs. 0.00</span>
                </div>
                <div class="total-row grand-total">
                    <span>Total</span>
                    <span id="totalDisplay">Rs. 0.00</span>
                </div>
            </div>

            <!-- Place Order Form -->
            <form action="${pageContext.request.contextPath}/order"
                  method="post" id="orderForm" novalidate>
                <input type="hidden" id="hiddenAddress"
                       name="deliveryAddress" value=""/>
                <div id="hiddenItems"></div>
                <button type="submit" class="btn-place-order"
                        id="placeOrderBtn">
                    Place Order • <span id="btnTotal">Rs. 0.00</span>
                </button>
            </form>

            <p class="delivery-estimate">
                Estimated Delivery: 35-45 Minutes
            </p>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="page-footer">
    <div class="footer-bottom">
        <p class="footer-brand">
            &copy; 2024 ByteBistro Editorial. All Rights Reserved.
        </p>
        <ul class="footer-links">
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">Terms of Service</a></li>
            <li><a href="#">Contact Ma&icirc;tre D&apos;</a></li>
        </ul>
    </div>
</footer>

<script>
    // Cart state
    var cart = {};
    var SERVICE_FEE_RATE = 0.05; // 5% service fee

    // Switch category tab
    function switchTab(typeId, btn) {
        document.querySelectorAll('.tab-btn').forEach(function(b) {
            b.classList.remove('active');
        });
        document.querySelectorAll('.menu-grid').forEach(function(g) {
            g.classList.remove('active');
        });
        btn.classList.add('active');
        var grid = document.getElementById('grid_' + typeId);
        if (grid) grid.classList.add('active');
    }

    // Add item to cart
    function addToCart(itemId, itemName, itemPrice) {
        if (cart[itemId]) {
            cart[itemId].quantity += 1;
        } else {
            cart[itemId] = {
                id: itemId,
                name: itemName,
                price: itemPrice,
                quantity: 1
            };
        }
        renderCart();
    }

    // Remove item from cart
    function removeFromCart(itemId) {
        delete cart[itemId];
        renderCart();
    }

    // Update quantity
    function updateQty(itemId, delta) {
        if (cart[itemId]) {
            cart[itemId].quantity += delta;
            if (cart[itemId].quantity <= 0) {
                delete cart[itemId];
            }
        }
        renderCart();
    }

    // Render cart items
    function renderCart() {
        var cartDiv = document.getElementById('cartItems');
        var hiddenItems = document.getElementById('hiddenItems');
        var keys = Object.keys(cart);

        hiddenItems.innerHTML = '';

        if (keys.length === 0) {
            cartDiv.innerHTML =
                '<p class="empty-cart">No items added yet.</p>';
            updateTotals(0);
            return;
        }

        var html = '';
        var subtotal = 0;

        keys.forEach(function(id) {
            var item = cart[id];
            var itemTotal = item.price * item.quantity;
            subtotal += itemTotal;

            html += '<div class="cart-item">';
            html += '<div class="cart-item-image"></div>';
            html += '<div class="cart-item-info">';
            html += '<p class="cart-item-name">' + item.name + '</p>';
            html += '<div class="cart-item-controls">';
            html += '<button class="qty-btn" onclick="updateQty(' +
                id + ', -1)">-</button>';
            html += '<span class="qty-display">' +
                item.quantity + '</span>';
            html += '<button class="qty-btn" onclick="updateQty(' +
                id + ', 1)">+</button>';
            html += '</div></div>';
            html += '<span class="cart-item-price">Rs.' +
                itemTotal.toFixed(2) + '</span>';
            html += '<button class="btn-remove" onclick="removeFromCart(' +
                id + ')">&#x2715;</button>';
            html += '</div>';

            // Add hidden inputs for form submission
            hiddenItems.innerHTML +=
                '<input type="hidden" name="itemId" value="' + id + '"/>' +
                '<input type="hidden" name="quantity" value="' +
                item.quantity + '"/>';
        });

        cartDiv.innerHTML = html;
        updateTotals(subtotal);
    }

    // Update totals display
    function updateTotals(subtotal) {
        var serviceFee = subtotal * SERVICE_FEE_RATE;
        var total = subtotal + serviceFee;

        document.getElementById('subtotalDisplay').textContent =
            'Rs. ' + subtotal.toFixed(2);
        document.getElementById('serviceFeeDisplay').textContent =
            'Rs. ' + serviceFee.toFixed(2);
        document.getElementById('totalDisplay').textContent =
            'Rs. ' + total.toFixed(2);
        document.getElementById('btnTotal').textContent =
            'Rs. ' + total.toFixed(2);
    }

    // Form submission validation
    document.getElementById('orderForm')
        .addEventListener('submit', function(e) {
            var address = document.getElementById('deliveryAddress').value.trim();
            var keys = Object.keys(cart);

            if (keys.length === 0) {
                alert('Please add at least one item to your order.');
                e.preventDefault();
                return;
            }

            if (!address) {
                alert('Please enter your delivery address.');
                e.preventDefault();
                return;
            }

            // Copy address to hidden field
            document.getElementById('hiddenAddress').value = address;
        });
</script>

</body>
</html>