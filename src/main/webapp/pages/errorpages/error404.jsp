<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/components/user-header.jsp" %>


<section style="padding: 120px 40px; text-align: center; background: #f5f5dc; min-height: 60vh;">

    <h1 style="font-size: 6rem; color: #2c1810; margin-bottom: 10px;">404</h1>
    <h2 style="font-size: 2rem; color: #c8a97e; margin-bottom: 20px;">Oops! Page Not Found</h2>
    <p style="color: #555; font-size: 1.1rem; margin-bottom: 40px;">
        The page you are looking for doesn't exist or has been moved.
    </p>

    <% String errorMsg = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMsg != null) { %>
    <p style="color: red; margin-bottom: 30px;"><%= errorMsg %></p>
    <% } %>

    <a href="<%= request.getContextPath() %>/pages/index.jsp"
       style="background: #2c1810; color: white; padding: 15px 40px; text-decoration: none; font-size: 1rem; margin-right: 15px;">
        GO HOME
    </a>
    <a href="<%= request.getContextPath() %>/pages/common/menu-view.jsp"
       style="background: #c8a97e; color: white; padding: 15px 40px; text-decoration: none; font-size: 1rem;">
        VIEW MENU
    </a>

</section>

<%@ include file="/components/user-footer.jsp" %>