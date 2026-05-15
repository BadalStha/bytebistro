<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/components/user-header.jsp" %>


<section style="background: #2c1810; color: white; padding: 100px 40px; text-align: center;">
    <h1 style="font-size: 3rem; margin-bottom: 20px;">Welcome to ByteBistro</h1>
    <p style="font-size: 1.2rem; margin-bottom: 40px;">A Culinary Editorial Experience</p>
    <a href="<%= request.getContextPath() %>/pages/common/menu-view.jsp"
       style="background: #c8a97e; color: white; padding: 15px 40px; text-decoration: none; font-size: 1rem;">
        VIEW OUR MENU
    </a>
</section>


<section style="padding: 80px 40px; text-align: center; background: #f5f5dc;">
    <h2 style="margin-bottom: 50px; font-size: 2rem; color: #2c1810;">WHY BYTEBISTRO?</h2>
    <div style="display: flex; justify-content: center; gap: 40px; flex-wrap: wrap;">
        <div style="width: 250px; padding: 30px; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #c8a97e; margin-bottom: 15px;">🍽️ Fine Dining</h3>
            <p>Experience world-class cuisine crafted by expert chefs.</p>
        </div>
        <div style="width: 250px; padding: 30px; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #c8a97e; margin-bottom: 15px;">📅 Easy Booking</h3>
            <p>Reserve your table in seconds, hassle-free.</p>
        </div>
        <div style="width: 250px; padding: 30px; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #c8a97e; margin-bottom: 15px;">⭐ Premium Experience</h3>
            <p>Members enjoy exclusive menus and priority seating.</p>
        </div>
    </div>
</section>


<section style="padding: 80px 40px; text-align: center; background: #2c1810; color: white;">
    <h2 style="margin-bottom: 20px; font-size: 2rem;">SPECIAL OFFER</h2>
    <p style="font-size: 1.1rem; margin-bottom: 30px;">Book a table today and get 10% off your first visit!</p>
    <a href="<%= request.getContextPath() %>/pages/visitor/booking-form.jsp"
       style="background: #c8a97e; color: white; padding: 15px 40px; text-decoration: none; font-size: 1rem;">
        BOOK A TABLE
    </a>
</section>

<%@ include file="/components/user-footer.jsp" %>