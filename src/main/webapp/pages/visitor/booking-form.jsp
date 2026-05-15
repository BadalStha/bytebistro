<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/components/user-header.jsp" %>


<section style="background: #2c1810; color: white; padding: 80px 40px; text-align: center;">
    <h1 style="font-size: 2.5rem; margin-bottom: 15px;">Book a Table</h1>
    <p style="font-size: 1.1rem;">Reserve your spot at ByteBistro — no account needed!</p>
</section>

<!-- Booking Form appears -->
<section style="padding: 80px 40px; max-width: 600px; margin: 0 auto;">

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
    <p style="color: red; margin-bottom: 20px; text-align: center;"><%= error %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/booking" method="post">
        <input type="hidden" name="action" value="visitorBooking"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Full Name</label>
        <input type="text" name="guestName" placeholder="Enter your full name" required
               style="width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; font-size: 1rem;"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Phone Number</label>
        <input type="text" name="phone" placeholder="Enter your phone number" required
               style="width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; font-size: 1rem;"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Date</label>
        <input type="date" name="bookingDate" required
               style="width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; font-size: 1rem;"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Time</label>
        <input type="time" name="bookingTime" required
               style="width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; font-size: 1rem;"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Number of Guests</label>
        <input type="number" name="guestCount" min="1" max="20" placeholder="How many guests?" required
               style="width: 100%; padding: 12px; margin-bottom: 20px; border: 1px solid #ddd; font-size: 1rem;"/>

        <label style="display: block; margin-bottom: 5px; color: #2c1810; font-weight: bold;">Special Requests</label>
        <textarea name="specialRequest" rows="4" placeholder="Any special requests? (optional)"
                  style="width: 100%; padding: 12px; margin-bottom: 30px; border: 1px solid #ddd; font-size: 1rem;"></textarea>

        <button type="submit"
                style="width: 100%; background: #2c1810; color: white; padding: 15px; border: none; font-size: 1rem; cursor: pointer;">
            CONFIRM BOOKING
        </button>
    </form>

</section>

<%@ include file="/components/user-footer.jsp" %>