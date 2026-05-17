<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<jsp:include page="../components/user-header.jsp" />

<div style="height: 70vh; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 0 24px;">
    
    <div style="font-family: var(--bb-font-display); font-size: clamp(8rem, 20vw, 12rem); line-height: 1; color: var(--bb-accent-soft); position: absolute; z-index: 0; user-select: none;">
        500
    </div>

    <div style="position: relative; z-index: 1; animation: bbFadeUp 0.8s ease both;">
        <span style="color: var(--bb-accent); font-weight: 700; text-transform: uppercase; letter-spacing: 0.2em; font-size: 0.8rem; display: block; margin-bottom: 16px;">UNEXPECTED FLAVORS</span>
        <h1 style="font-family: var(--bb-font-display); font-size: 3.5rem; margin-bottom: 24px; font-style: italic;">A Recipe Gone Wrong</h1>
        <p style="color: var(--bb-text-muted); font-size: 1.1rem; max-width: 500px; margin: 0 auto 48px; line-height: 1.7;">
            We encountered a hiccup in our kitchen while preparing your request. Our chefs have been notified and are resolving the issue.
        </p>

        <% String errorMsg = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMsg != null) { %>
        <div class="bb-alert bb-alert--danger" style="display: inline-flex; margin-bottom: 40px;">
            <i class="fa-solid fa-circle-exclamation"></i>
            &nbsp; <%= errorMsg %>
        </div>
        <% } %>

        <div style="display: flex; gap: 20px; justify-content: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="bb-btn bb-btn--primary" style="padding: 14px 40px;">
                Return Home
            </a>
            <button onclick="window.location.reload();" class="bb-btn bb-btn--outline" style="padding: 14px 40px;">
                Try Again
            </button>
        </div>
    </div>
</div>

<jsp:include page="../components/user-footer.jsp" />
