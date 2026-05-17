<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.bytebistro.user.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    User user = (User) request.getAttribute("user");
    String fullName = (user != null) ? user.getFullName() : "";
    String email    = (user != null) ? user.getEmail() : "";
    String phone    = (user != null) ? user.getPhone() : "";
    String role     = (user != null) ? user.getRole() : "member";
    String createdAt = (user != null && user.getCreatedAt() != null)
            ? new java.text.SimpleDateFormat("MMMM yyyy").format(user.getCreatedAt()) : "N/A";
    String initial  = (!fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";

    request.setAttribute("fullName", fullName);
    request.setAttribute("email", email);
    request.setAttribute("phone", phone);
    request.setAttribute("role", role);
    request.setAttribute("createdAt", createdAt);
    request.setAttribute("initial", initial);
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Personal <span style="font-style: italic; color: var(--bb-accent);">Identity</span></h1>
    <p class="bb-page-sub">Manage your culinary profile and security credentials.</p>
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

<div style="display: grid; grid-template-columns: 320px 1fr; gap: 32px; align-items: start;">

    <!-- Left Sidebar: Identity Card -->
    <div style="display: flex; flex-direction: column; gap: 24px;">
        <div class="bb-card" style="text-align: center; padding: 40px 24px;">
            <div style="width: 100px; height: 100px; border-radius: 50%; background: var(--bb-accent-soft); border: 2px solid var(--bb-accent); color: var(--bb-accent); font-family: var(--bb-font-display); font-size: 3rem; display: flex; align-items: center; justify-content: center; margin: 0 auto 24px; box-shadow: var(--bb-shadow);">
                ${initial}
            </div>
            <h2 style="font-family: var(--bb-font-display); font-size: 1.5rem; color: #fff; margin-bottom: 4px;">${fullName}</h2>
            <div style="font-size: 0.7rem; color: var(--bb-accent); text-transform: uppercase; letter-spacing: 0.2em; font-weight: 700; margin-bottom: 32px;">
                ${role}
            </div>

            <div style="text-align: left; display: flex; flex-direction: column; gap: 20px;">
                <div>
                    <label class="bb-label" style="font-size: 0.65rem;">Email Address</label>
                    <div style="font-size: 0.9rem; color: #fff; font-weight: 500;">${email}</div>
                </div>
                <div style="border-top: 1px solid var(--bb-border); padding-top: 20px;">
                    <label class="bb-label" style="font-size: 0.65rem;">Member Since</label>
                    <div style="font-size: 0.9rem; color: #fff; font-weight: 500;">${createdAt}</div>
                </div>
            </div>

            <div style="margin-top: 40px; padding-top: 24px; border-top: 1px solid var(--bb-border);">
                <a href="${pageContext.request.contextPath}/logout" class="bb-btn bb-btn--outline" style="width: 100%; color: var(--bb-danger); border-color: rgba(224, 92, 92, 0.2);">
                    <i class="fa-solid fa-right-from-bracket"></i> Sign Out
                </a>
            </div>
        </div>

        <div class="bb-card" style="background: var(--bb-surface-2); padding: 24px; text-align: center;">
            <div style="font-size: 0.7rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 8px;">Reservations Made</div>
            <div style="font-family: var(--bb-font-display); font-size: 3rem; font-weight: 700; color: var(--bb-accent);">${not empty totalBookings ? totalBookings : '0'}</div>
        </div>
    </div>

    <!-- Right Panel: Edit Sections -->
    <div style="display: flex; flex-direction: column; gap: 32px;">

        <!-- Section: Information -->
        <div class="bb-card">
            <div class="bb-card-header">
                <h3 class="bb-card-title"><i class="fa-solid fa-user-pen" style="margin-right: 12px; font-size: 1rem;"></i>Profile Information</h3>
            </div>
            <form action="${pageContext.request.contextPath}/profile" method="post" id="profileForm">
                <input type="hidden" name="action" value="updateProfile"/>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 32px;">
                    <div class="bb-form-group">
                        <label class="bb-label" for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="bb-input" value="${fullName}" required />
                    </div>
                    <div class="bb-form-group">
                        <label class="bb-label" for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" class="bb-input" value="${phone}" required />
                    </div>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <a href="${pageContext.request.contextPath}/profile" style="color: var(--bb-text-muted); font-size: 0.8rem; text-decoration: none; text-transform: uppercase; letter-spacing: 0.1em;">Discard Changes</a>
                    <button type="submit" class="bb-btn bb-btn--primary">Update Profile</button>
                </div>
            </form>
        </div>

        <!-- Section: Security -->
        <div class="bb-card">
            <div class="bb-card-header">
                <h3 class="bb-card-title"><i class="fa-solid fa-shield-halved" style="margin-right: 12px; font-size: 1rem;"></i>Account Security</h3>
            </div>
            <form action="${pageContext.request.contextPath}/profile" method="post" id="passwordForm">
                <input type="hidden" name="action" value="changePassword"/>

                <div class="bb-form-group" style="max-width: 400px; margin-bottom: 32px;">
                    <label class="bb-label" for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" class="bb-input" placeholder="••••••••" />
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 32px;">
                    <div class="bb-form-group">
                        <label class="bb-label" for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" class="bb-input" placeholder="••••••••" />
                    </div>
                    <div class="bb-form-group">
                        <label class="bb-label" for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="bb-input" placeholder="••••••••" />
                    </div>
                </div>

                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <a href="${pageContext.request.contextPath}/profile" style="color: var(--bb-text-muted); font-size: 0.8rem; text-decoration: none; text-transform: uppercase; letter-spacing: 0.1em;">Keep Current Password</a>
                    <button type="submit" class="bb-btn bb-btn--primary">Change Password</button>
                </div>
            </form>
        </div>


    </div>
</div>

<script>
    // Unified Validation Logic
    document.addEventListener('DOMContentLoaded', function() {
        const profileForm = document.getElementById('profileForm');
        const passwordForm = document.getElementById('passwordForm');

        if (profileForm) {
            profileForm.addEventListener('submit', function(e) {
                const fullName = document.getElementById('fullName').value.trim();
                const phone = document.getElementById('phone').value.trim();

                if (!fullName || !phone) {
                    alert('Identity credentials and contact number are required.');
                    e.preventDefault(); return;
                }
                if (!/^[a-zA-Z ]+$/.test(fullName)) {
                    alert('Identity name must contain only standard alphabetical characters.');
                    e.preventDefault(); return;
                }
                if (!/^\d{10,15}$/.test(phone)) {
                    alert('Phone number must be between 10 and 15 digits.');
                    e.preventDefault(); return;
                }
            });
        }

        if (passwordForm) {
            passwordForm.addEventListener('submit', function(e) {
                const current = document.getElementById('currentPassword').value;
                const newPass = document.getElementById('newPassword').value;
                const confirm = document.getElementById('confirmPassword').value;

                if (!current || !newPass || !confirm) {
                    alert('All security fields are mandatory for password rotation.');
                    e.preventDefault(); return;
                }
                if (newPass.length < 6) {
                    alert('Security keys must be at least 6 characters in length.');
                    e.preventDefault(); return;
                }
                if (newPass !== confirm) {
                    alert('Security keys do not match. Please verify your input.');
                    e.preventDefault(); return;
                }
            });
        }
    });
</script>

<jsp:include page="../../components/user-footer.jsp" />