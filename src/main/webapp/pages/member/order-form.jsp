<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bytebistro.menu.model.MenuItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
            
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
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
    request.setAttribute("groupedMenu", grouped);
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Curated <span style="font-style: italic; color: var(--bb-accent);">Selection</span></h1>
    <p class="bb-page-sub">Select your preferred dishes and experience culinary excellence at home.</p>
</div>

<%-- Alerts --%>
<c:if test="${not empty requestScope.error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-circle-exclamation"></i>
        ${requestScope.error}
    </div>
</c:if>
<c:if test="${not empty param.success}">
    <div class="bb-alert bb-alert--success">
        <i class="fa-solid fa-circle-check"></i>
        ${param.success}
    </div>
</c:if>

<div style="display: grid; grid-template-columns: 1fr 340px; gap: 40px; align-items: start;">
    
    <!-- Left Panel: Menu Selection -->
    <div>
        <!-- Category Navigation -->
        <div style="display: flex; gap: 32px; border-bottom: 1px solid var(--bb-border); margin-bottom: 32px; overflow-x: auto; padding-bottom: 4px; scrollbar-width: none;">
            <c:forEach items="${groupedMenu}" var="entry" varStatus="status">
                <button class="bb-tab-btn ${status.first ? 'active' : ''}" 
                        onclick="switchCategory('${entry.key}', this)"
                        style="background: none; border: none; font-family: var(--bb-font-display); font-size: 1.1rem; color: ${status.first ? '#fff' : 'var(--bb-text-muted)'}; cursor: pointer; padding-bottom: 12px; border-bottom: 2px solid ${status.first ? 'var(--bb-accent)' : 'transparent'}; transition: all 0.2s; white-space: nowrap;">
                    ${entry.key}
                </button>
            </c:forEach>
        </div>

        <!-- Menu Grids -->
        <c:forEach items="${groupedMenu}" var="entry" varStatus="status">
            <div id="category-${entry.key}" class="menu-category-grid" style="display: ${status.first ? 'grid' : 'none'}; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px;">
                <c:forEach items="${entry.value}" var="item">
                    <div class="bb-card" style="padding: 0; overflow: hidden; display: flex; flex-direction: column;">
                        <div style="height: 180px; background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.4)), url('https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80') center/cover;"></div>
                        <div style="padding: 20px; flex: 1; display: flex; flex-direction: column;">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px;">
                                <h4 style="font-family: var(--bb-font-display); font-size: 1.15rem; color: #fff;">${item.name}</h4>
                                <span style="font-weight: 700; color: var(--bb-accent);">Rs. ${item.price}</span>
                            </div>
                            <p style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.5; margin-bottom: 20px; flex: 1;">${item.description}</p>
                            <button class="bb-btn bb-btn--outline" style="width: 100%;" 
                                    onclick="addToCart('${item.itemId}', '${item.name}', ${item.price})">
                                <i class="fa-solid fa-plus" style="margin-right: 8px;"></i> Add to Selection
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <!-- Right Panel: Order Summary / Cart -->
    <div style="position: sticky; top: 100px;">
        <div class="bb-card">
            <div class="bb-card-header" style="padding-bottom: 12px; border-bottom: 1px solid var(--bb-border); margin-bottom: 20px;">
                <h3 class="bb-card-title">Your Selection</h3>
            </div>
            
            <div id="cartItems" style="display: flex; flex-direction: column; gap: 16px; margin-bottom: 24px; min-height: 60px;">
                <div style="text-align: center; color: var(--bb-text-muted); padding: 32px 0;">
                    <i class="fa-solid fa-basket-shopping" style="font-size: 2rem; margin-bottom: 12px; opacity: 0.3;"></i>
                    <p style="font-size: 0.85rem;">No items selected yet.</p>
                </div>
            </div>

            <div class="bb-form-group">
                <label class="bb-label">Delivery Destination</label>
                <textarea id="deliveryAddress" class="bb-input" rows="3" placeholder="Enter your full address..." style="resize: none;"></textarea>
            </div>

            <div style="margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--bb-border);">
                <div style="display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem;">
                    <span style="color: var(--bb-text-muted);">Subtotal</span>
                    <span id="subtotalDisplay" style="color: #fff; font-weight: 600;">Rs. 0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 16px; font-size: 0.9rem;">
                    <span style="color: var(--bb-text-muted);">Service Fee (5%)</span>
                    <span id="serviceFeeDisplay" style="color: #fff; font-weight: 600;">Rs. 0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 32px;">
                    <span style="font-family: var(--bb-font-display); font-size: 1.25rem; color: #fff;">Total</span>
                    <span id="totalDisplay" style="font-family: var(--bb-font-display); font-size: 1.25rem; color: var(--bb-accent); font-weight: 700;">Rs. 0.00</span>
                </div>

                <form action="${pageContext.request.contextPath}/order" method="post" id="orderForm">
                    <input type="hidden" id="hiddenAddress" name="deliveryAddress" value=""/>
                    <div id="hiddenItems"></div>
                    <button type="submit" class="bb-btn bb-btn--primary" style="width: 100%; padding: 16px;">
                        Finalize Order • <span id="btnTotalDisplay">Rs. 0.00</span>
                    </button>
                </form>
                <p style="text-align: center; font-size: 0.65rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; margin-top: 16px;">
                    Estimated fulfillment: 35-45 minutes
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    // Cart management
    let cart = {};
    const SERVICE_FEE_RATE = 0.05;

    function switchCategory(categoryName, btn) {
        document.querySelectorAll('.bb-tab-btn').forEach(b => {
            b.style.color = 'var(--bb-text-muted)';
            b.style.borderBottomColor = 'transparent';
        });
        document.querySelectorAll('.menu-category-grid').forEach(g => g.style.display = 'none');
        
        btn.style.color = '#fff';
        btn.style.borderBottomColor = 'var(--bb-accent)';
        const grid = document.getElementById('category-' + categoryName);
        if (grid) grid.style.display = 'grid';
    }

    function addToCart(id, name, price) {
        if (cart[id]) {
            cart[id].quantity += 1;
        } else {
            cart[id] = { id, name, price, quantity: 1 };
        }
        renderCart();
    }

    function updateQty(id, delta) {
        if (cart[id]) {
            cart[id].quantity += delta;
            if (cart[id].quantity <= 0) delete cart[id];
            renderCart();
        }
    }

    function removeFromCart(id) {
        delete cart[id];
        renderCart();
    }

    function renderCart() {
        const cartDiv = document.getElementById('cartItems');
        const hiddenItems = document.getElementById('hiddenItems');
        const keys = Object.keys(cart);
        
        hiddenItems.innerHTML = '';
        
        if (keys.length === 0) {
            cartDiv.innerHTML = `<div style="text-align: center; color: var(--bb-text-muted); padding: 32px 0;">
                <i class="fa-solid fa-basket-shopping" style="font-size: 2rem; margin-bottom: 12px; opacity: 0.3;"></i>
                <p style="font-size: 0.85rem;">No items selected yet.</p>
            </div>`;
            updateTotals(0);
            return;
        }

        let html = '';
        let subtotal = 0;
        
        keys.forEach(id => {
            const item = cart[id];
            const itemTotal = item.price * item.quantity;
            subtotal += itemTotal;
            
            html += `
                <div style="display: flex; gap: 12px; align-items: flex-start;">
                    <div style="flex: 1;">
                        <div style="font-size: 0.85rem; font-weight: 600; color: #fff; margin-bottom: 4px;">${item.name}</div>
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <button onclick="updateQty('${id}', -1)" style="width: 20px; height: 20px; border-radius: 4px; border: 1px solid var(--bb-border); background: none; color: #fff; cursor: pointer;">-</button>
                            <span style="font-size: 0.8rem; min-width: 16px; text-align: center;">${item.quantity}</span>
                            <button onclick="updateQty('${id}', 1)" style="width: 20px; height: 20px; border-radius: 4px; border: 1px solid var(--bb-border); background: none; color: #fff; cursor: pointer;">+</button>
                        </div>
                    </div>
                    <div style="text-align: right;">
                        <div style="font-size: 0.85rem; font-weight: 700; color: var(--bb-accent);">Rs. ${itemTotal.toFixed(2)}</div>
                        <button onclick="removeFromCart('${id}')" style="background: none; border: none; color: var(--bb-text-muted); cursor: pointer; font-size: 0.7rem; text-transform: uppercase; margin-top: 4px;">Remove</button>
                    </div>
                </div>
            `;
            
            hiddenItems.innerHTML += `<input type="hidden" name="itemId" value="${id}"/><input type="hidden" name="quantity" value="${item.quantity}"/>`;
        });
        
        cartDiv.innerHTML = html;
        updateTotals(subtotal);
    }

    function updateTotals(subtotal) {
        const fee = subtotal * SERVICE_FEE_RATE;
        const total = subtotal + fee;
        
        document.getElementById('subtotalDisplay').textContent = 'Rs. ' + subtotal.toFixed(2);
        document.getElementById('serviceFeeDisplay').textContent = 'Rs. ' + fee.toFixed(2);
        document.getElementById('totalDisplay').textContent = 'Rs. ' + total.toFixed(2);
        document.getElementById('btnTotalDisplay').textContent = 'Rs. ' + total.toFixed(2);
    }

    document.getElementById('orderForm').addEventListener('submit', function(e) {
        const address = document.getElementById('deliveryAddress').value.trim();
        const keys = Object.keys(cart);
        
        if (keys.length === 0) {
            alert('Your selection is empty. Please add at least one dish.');
            e.preventDefault();
            return;
        }
        if (!address) {
            alert('A delivery destination is required to finalize your order.');
            e.preventDefault();
            return;
        }
        document.getElementById('hiddenAddress').value = address;
    });
</script>

<jsp:include page="../../components/user-footer.jsp" />