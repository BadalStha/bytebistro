<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.bytebistro.rating.model.Rating" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Share Your Experience - ByteBistro</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

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

        .navbar-links a.active,
        .navbar-links a:hover {
            color: #8B0000;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 2px;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .btn-book {
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

        .btn-book:hover { background: #6b0000; }

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
        }

        /* ── Page Container ── */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 56px 24px 80px;
        }

        /* ── Page Header ── */
        .page-header {
            margin-bottom: 48px;
        }

        .page-header h1 {
            font-family: 'Georgia', serif;
            font-size: 52px;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 16px;
            line-height: 1.1;
        }

        .page-header p {
            font-size: 15px;
            color: #555;
            line-height: 1.7;
            max-width: 520px;
        }

        /* ── Alerts ── */
        .alert {
            padding: 12px 16px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 24px;
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

        /* ── Main Layout ── */
        .main-layout {
            display: flex;
            gap: 48px;
            align-items: flex-start;
        }

        /* ── Left Panel ── */
        .left-panel {
            width: 240px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .restaurant-image {
            width: 100%;
            height: 220px;
            border-radius: 8px;
            background: linear-gradient(
                    135deg,
                    rgba(30,20,20,0.85) 0%,
                    rgba(60,30,30,0.6) 100%
            ),
            url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400')
            center/cover;
            overflow: hidden;
        }

        .philosophy-card {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .philosophy-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #8B0000;
        }

        .philosophy-quote {
            font-family: 'Georgia', serif;
            font-style: italic;
            font-size: 15px;
            color: #333;
            line-height: 1.7;
        }

        /* ── Right Panel ── */
        .right-panel {
            flex: 1;
        }

        /* ── Rating Row ── */
        .rating-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 24px 0;
            border-bottom: 1px solid #e0dfc8;
        }

        .rating-row:first-child {
            padding-top: 0;
        }

        .rating-label {
            font-family: 'Georgia', serif;
            font-size: 20px;
            font-weight: 700;
            color: #1a1a1a;
        }

        /* ── Star Rating ── */
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            gap: 4px;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            font-size: 28px;
            color: #ddd;
            cursor: pointer;
            transition: color 0.15s;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input:checked ~ label {
            color: #c8a96e;
        }

        /* ── Comment Section ── */
        .comment-section {
            margin-top: 32px;
            margin-bottom: 28px;
        }

        .comment-label {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 12px;
            display: block;
        }

        .comment-textarea {
            width: 100%;
            padding: 16px;
            border: none;
            border-bottom: 1px solid #c8c8a8;
            background: transparent;
            font-size: 14px;
            color: #333;
            font-family: 'Arial', sans-serif;
            resize: none;
            outline: none;
            height: 120px;
            transition: border-color 0.2s;
        }

        .comment-textarea:focus {
            border-bottom-color: #8B0000;
        }

        .comment-textarea::placeholder {
            color: #bbb;
            font-style: italic;
        }

        /* ── User Fields Row ── */
        .user-fields-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
        }

        .user-field label {
            display: block;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #888;
            margin-bottom: 8px;
        }

        .user-field input {
            width: 100%;
            padding: 10px 0;
            border: none;
            border-bottom: 1px solid #c8c8a8;
            background: transparent;
            font-size: 14px;
            color: #333;
            outline: none;
            font-family: 'Arial', sans-serif;
            transition: border-color 0.2s;
        }

        .user-field input:focus {
            border-bottom-color: #8B0000;
        }

        .user-field input::placeholder {
            color: #ccc;
        }

        /* ── Submit Button ── */
        .submit-row {
            display: flex;
            justify-content: flex-end;
        }

        .btn-submit {
            background: #8B0000;
            color: #fff;
            border: none;
            padding: 16px 40px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s;
            font-family: 'Arial', sans-serif;
        }

        .btn-submit:hover { background: #6b0000; }

        /* ── Decorative Divider ── */
        .decorative-divider {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            margin-top: 56px;
        }

        .divider-line {
            width: 80px;
            height: 1px;
            background: #c8c8a8;
        }

        .divider-icon {
            font-size: 18px;
            color: #c8a96e;
        }

        /* ── Footer ── */
        .page-footer {
            background: #fff;
            padding: 32px 40px;
            margin-top: 40px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
        }

        .footer-brand {
            font-family: 'Georgia', serif;
            font-size: 18px;
            font-style: italic;
            color: #8B0000;
            font-weight: 700;
        }

        .footer-copy {
            font-size: 11px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #aaa;
            margin-top: 4px;
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

        .footer-links a:hover { color: #8B0000; }

        /* ── Already Rated Banner ── */
        .already-rated {
            background: #fff;
            border-radius: 8px;
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-left: 3px solid #c8a96e;
        }

        .already-rated p {
            font-size: 13px;
            color: #555;
        }

        .already-rated span {
            font-size: 20px;
        }

        /* ── Responsive ── */
        @media (max-width: 768px) {
            .main-layout {
                flex-direction: column;
            }

            .left-panel {
                width: 100%;
            }

            .page-header h1 {
                font-size: 36px;
            }

            .user-fields-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<%
    String fullName = (String) session.getAttribute("fullName");
    String initial  = (fullName != null && !fullName.isEmpty())
            ? String.valueOf(fullName.charAt(0)).toUpperCase() : "U";
    Rating existingRating =
            (Rating) request.getAttribute("existingRating");

    // Pre-fill ratings if existing
    int existingFood    = existingRating != null ?
            existingRating.getFoodRating() : 0;
    int existingStaff   = existingRating != null ?
            existingRating.getStaffRating() : 0;
    int existingAmbience = existingRating != null ?
            existingRating.getAmbienceRating() : 0;
    String existingComment = existingRating != null &&
            existingRating.getComment() != null ?
            existingRating.getComment() : "";
%>

<!-- Navbar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/"
       class="navbar-brand">ByteBistro</a>
    <ul class="navbar-links">
        <li>
            <a href="${pageContext.request.contextPath}/booking">
                Reservations</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp">
                Menu</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/order">
                Orders</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/rating"
               class="active">Feedback</a>
        </li>
    </ul>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/booking"
           class="btn-book">Book a Table</a>
        <div class="user-avatar"><%= initial %></div>
    </div>
</nav>

<!-- Page Container -->
<div class="container">

    <!-- Page Header -->
    <div class="page-header">
        <h1>Share Your Experience</h1>
        <p>Your feedback is the vital ingredient in our pursuit
            of culinary excellence. Whether a member of our inner
            circle or a first-time visitor, your voice shapes the
            atmosphere of ByteBistro.</p>
    </div>

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

    <%-- Already Rated Banner --%>
    <% if (existingRating != null) { %>
    <div class="already-rated">
        <span>&#11088;</span>
        <p>You have already submitted a rating.
            You can update it below.</p>
    </div>
    <% } %>

    <!-- Main Layout -->
    <div class="main-layout">

        <!-- Left Panel -->
        <div class="left-panel">
            <div class="restaurant-image"></div>
            <div class="philosophy-card">
                <span class="philosophy-label">Philosophy</span>
                <p class="philosophy-quote">
                    &ldquo;A meal is not just food; it is a narrative
                    composed of service, soul, and flavor.&rdquo;
                </p>
            </div>
        </div>

        <!-- Right Panel -->
        <div class="right-panel">
            <form action="${pageContext.request.contextPath}/rating"
                  method="post" id="ratingForm" novalidate>

                <!-- Food Quality -->
                <div class="rating-row">
                    <span class="rating-label">Food Quality</span>
                    <div class="star-rating" id="foodStars">
                        <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio"
                               id="food<%= i %>"
                               name="foodRating"
                               value="<%= i %>"
                                <%= existingFood == i ?
                                        "checked" : "" %>/>
                        <label for="food<%= i %>">&#9733;</label>
                        <% } %>
                    </div>
                </div>

                <!-- Staff Behavior -->
                <div class="rating-row">
                    <span class="rating-label">Staff Behavior</span>
                    <div class="star-rating" id="staffStars">
                        <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio"
                               id="staff<%= i %>"
                               name="staffRating"
                               value="<%= i %>"
                                <%= existingStaff == i ?
                                        "checked" : "" %>/>
                        <label for="staff<%= i %>">&#9733;</label>
                        <% } %>
                    </div>
                </div>

                <!-- Ambience -->
                <div class="rating-row">
                    <span class="rating-label">Ambience</span>
                    <div class="star-rating" id="ambienceStars">
                        <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio"
                               id="ambience<%= i %>"
                               name="ambienceRating"
                               value="<%= i %>"
                                <%= existingAmbience == i ?
                                        "checked" : "" %>/>
                        <label for="ambience<%= i %>">&#9733;</label>
                        <% } %>
                    </div>
                </div>

                <!-- Comment -->
                <div class="comment-section">
                    <label class="comment-label">
                        Elaborate On Your Visit
                    </label>
                    <textarea
                            class="comment-textarea"
                            name="comment"
                            placeholder="Tell us about the nuances of your evening..."
                    ><%= existingComment %></textarea>
                </div>

                <!-- User Fields -->
                <div class="user-fields-row">
                    <div class="user-field">
                        <label>Full Name</label>
                        <input
                                type="text"
                                value="<%= fullName != null ? fullName : "" %>"
                                readonly
                                placeholder="Your name"
                        />
                    </div>
                    <div class="user-field">
                        <label>Membership ID (Optional)</label>
                        <input
                                type="text"
                                value="<%= session.getAttribute("userId") %>"
                                readonly
                                placeholder="Your membership ID"
                        />
                    </div>
                </div>

                <!-- Submit -->
                <div class="submit-row">
                    <button type="submit" class="btn-submit">
                        Submit Experience
                    </button>
                </div>

            </form>
        </div>
    </div>

    <!-- Decorative Divider -->
    <div class="decorative-divider">
        <div class="divider-line"></div>
        <span class="divider-icon">&#127860;</span>
        <div class="divider-line"></div>
    </div>

</div>

<!-- Footer -->
<footer class="page-footer">
    <div>
        <p class="footer-brand">ByteBistro</p>
        <p class="footer-copy">
            &copy; 2024 ByteBistro Editorial.
            Established in Excellence.
        </p>
    </div>
    <ul class="footer-links">
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
        <li><a href="#">Press Kit</a></li>
        <li><a href="#">Contact Us</a></li>
    </ul>
</footer>

<script>
    document.getElementById('ratingForm')
        .addEventListener('submit', function(e) {

            var foodRating = document.querySelector(
                'input[name="foodRating"]:checked');
            var staffRating = document.querySelector(
                'input[name="staffRating"]:checked');
            var ambienceRating = document.querySelector(
                'input[name="ambienceRating"]:checked');

            if (!foodRating) {
                alert('Please rate Food Quality.');
                e.preventDefault(); return;
            }
            if (!staffRating) {
                alert('Please rate Staff Behavior.');
                e.preventDefault(); return;
            }
            if (!ambienceRating) {
                alert('Please rate Ambience.');
                e.preventDefault(); return;
            }
        });
</script>

</body>
</html>