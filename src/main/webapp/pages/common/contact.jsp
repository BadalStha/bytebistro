<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/components/user-header.jsp" %>


<section style="background: #2c1810; color: white; padding: 80px 40px; text-align: center;">
    <h1 style="font-size: 2.5rem; margin-bottom: 15px;">Contact Us</h1>
    <p style="font-size: 1.1rem;">We'd love to hear from you!</p>
</section>


<section style="padding: 80px 40px; max-width: 1000px; margin: 0 auto; display: flex; gap: 60px; flex-wrap: wrap;">


    <div style="flex: 1; min-width: 250px;">
        <h2 style="color: #2c1810; margin-bottom: 30px;">Get In Touch</h2>
        <p style="margin-bottom: 15px; color: #555;">📍 123 Bistro Street, Kathmandu, Nepal</p>
        <p style="margin-bottom: 15px; color: #555;">📞 +977-01-1234567</p>
        <p style="margin-bottom: 15px; color: #555;">📧 hello@bytebistro.com</p>
        <p style="margin-bottom: 15px; color: #555;">🕐 Mon-Sun: 10:00 AM - 10:00 PM</p>
    </div>


    <div style="flex: 1; min-width: 250px;">
        <h2 style="color: #2c1810; margin-bottom: 30px;">Send a Message</h2>
        <input type="text" placeholder="Your Name"
               style="width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; font-size: 1rem;"/>
        <input type="email" placeholder="Your Email"
               style="width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; font-size: 1rem;"/>
        <textarea placeholder="Your Message" rows="5"
                  style="width: 100%; padding: 12px; margin-bottom: 15px; border: 1px solid #ddd; font-size: 1rem;"></textarea>
        <button style="background: #2c1810; color: white; padding: 12px 40px; border: none; font-size: 1rem; cursor: pointer;">
            SEND MESSAGE
        </button>
    </div>

</section>

<%@ include file="/components/user-footer.jsp" %>