<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/components/user-header.jsp" %>

<!-- Section: Hero Experience -->
<section style="position: relative; height: 95vh; display: flex; align-items: center; justify-content: center; overflow: hidden; background: #000; margin-top: -32px; margin-left: -32px; width: calc(100% + 64px);">
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: linear-gradient(to bottom, rgba(0,0,0,0.2), rgba(0,0,0,0.8)), url('https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=1920&q=80') center/cover; transform: scale(1.05); animation: bbHeroPulse 20s infinite alternate;"></div>
    
    <div style="position: relative; text-align: center; max-width: 900px; padding: 0 24px; animation: bbFadeIn 1.2s ease-out both;">
        <span style="display: block; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5em; color: var(--bb-accent); margin-bottom: 24px; font-weight: 700;">ESTABLISHED IN EXCELLENCE</span>
        <h1 style="font-family: var(--bb-font-display); font-size: clamp(3.5rem, 10vw, 6rem); line-height: 1.05; margin-bottom: 32px; font-weight: 700; color: #fff;">A Culinary<br><span style="font-style: italic; color: var(--bb-accent);">Editorial</span></h1>
        <p style="font-size: clamp(1.1rem, 3vw, 1.3rem); color: rgba(255,255,255,0.8); line-height: 1.6; margin-bottom: 56px; max-width: 650px; margin-left: auto; margin-right: auto; font-weight: 300;">
            Experience world-class cuisine crafted by expert chefs in an atmosphere designed for the sophisticated palate.
        </p>
        <div style="display: flex; gap: 24px; justify-content: center;">
            <a href="${pageContext.request.contextPath}/pages/common/menu-view.jsp" class="bb-btn bb-btn--primary" style="padding: 18px 48px; font-size: 1rem; border-radius: 40px;">
                Explore the Menu
            </a>
            <a href="${pageContext.request.contextPath}/pages/member/member-booking-form.jsp" class="bb-btn bb-btn--outline" style="padding: 18px 48px; font-size: 1rem; border-radius: 40px; border-color: rgba(255,255,255,0.3);">
                Reserve a Table
            </a>
        </div>
    </div>
</section>

<!-- Section: The Philosophy -->
<section style="padding: 140px 0; background: var(--bb-bg);">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 24px;">
        <div style="text-align: center; margin-bottom: 100px;">
            <span style="color: var(--bb-accent); font-weight: 700; text-transform: uppercase; letter-spacing: 0.2em; font-size: 0.75rem;">OUR ESSENCE</span>
            <h2 style="font-family: var(--bb-font-display); font-size: 3.5rem; margin-top: 16px; margin-bottom: 20px; font-style: italic;">Why ByteBistro?</h2>
            <div style="width: 80px; height: 2px; background: var(--bb-accent); margin: 0 auto;"></div>
        </div>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 48px;">
            <div class="bb-card bb-feature-card">
                <div class="bb-feature-icon"><i class="fa-solid fa-plate-wheat"></i></div>
                <h3 class="bb-feature-title">Fine Dining</h3>
                <p class="bb-feature-text">Our menu is a curated collection of culinary masterpieces, using only the finest seasonal ingredients sourced globally.</p>
            </div>
            
            <div class="bb-card bb-feature-card bb-feature-card--active">
                <div class="bb-feature-icon"><i class="fa-solid fa-calendar-check"></i></div>
                <h3 class="bb-feature-title">Precision Booking</h3>
                <p class="bb-feature-text">Seamlessly reserve your preferred table. Our concierge system ensures your evening is perfectly staged before you arrive.</p>
            </div>
            
            <div class="bb-card bb-feature-card">
                <div class="bb-feature-icon"><i class="fa-solid fa-crown"></i></div>
                <h3 class="bb-feature-title">Elite Membership</h3>
                <p class="bb-feature-text">Join our inner circle for priority access, exclusive tasting menus, and dedicated sommelier services.</p>
            </div>
        </div>
    </div>
</section>

<!-- Section: Accolades Row -->
<div style="background: var(--bb-surface); padding: 60px 0; border-top: 1px solid var(--bb-border); border-bottom: 1px solid var(--bb-border);">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 24px; display: flex; justify-content: space-around; align-items: center; opacity: 0.5; filter: grayscale(1);">
        <div style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-text);">Michelin 2024</div>
        <div style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-text);">James Beard</div>
        <div style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-text);">Wine Spectator</div>
        <div style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-text);">World's 50 Best</div>
    </div>
</div>

<!-- Section: The Membership Banner -->
<section style="padding: 140px 24px; background: var(--bb-bg);">
    <div style="max-width: 1100px; margin: 0 auto; display: grid; grid-template-columns: 1.2fr 1fr; gap: 80px; align-items: center;">
        <div>
            <span style="color: var(--bb-accent); font-weight: 700; text-transform: uppercase; letter-spacing: 0.2em; font-size: 0.75rem;">CURATED PRIVILEGES</span>
            <h2 style="font-family: var(--bb-font-display); font-size: 3.5rem; margin-top: 16px; margin-bottom: 32px; font-style: italic; line-height: 1.1;">Elevate Your<br>Culinary Journey</h2>
            <p style="color: var(--bb-text-muted); font-size: 1.15rem; line-height: 1.8; margin-bottom: 48px;">
                ByteBistro members enjoy an unprecedented level of service, including early-bird reservations, bespoke event planning, and a 10% preference on all library wine selections.
            </p>
            <a href="${pageContext.request.contextPath}/pages/common/register.jsp" class="bb-btn bb-btn--primary" style="padding: 16px 48px; border-radius: 40px;">Join the Editorial</a>
        </div>
        <div style="position: relative;">
            <div style="position: absolute; top: -30px; right: -30px; width: 100%; height: 100%; border: 1px solid var(--bb-accent); z-index: 0; opacity: 0.3;"></div>
            <div class="bb-card" style="padding: 0; overflow: hidden; border: none; border-radius: var(--bb-radius-lg); position: relative; z-index: 1; box-shadow: 0 40px 80px rgba(0,0,0,0.5);">
                <img src="https://images.unsplash.com/photo-1550966841-3ee3228784d7?auto=format&fit=crop&w=800&q=80" 
                     style="width: 100%; height: 550px; object-fit: cover;" alt="Dining">
            </div>
        </div>
    </div>
</section>

<style>
    .bb-feature-card {
        text-align: center;
        padding: 64px 40px;
        transition: 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
        border-color: var(--bb-border);
    }
    .bb-feature-card:hover {
        transform: translateY(-12px);
        border-color: var(--bb-accent);
        box-shadow: 0 30px 60px rgba(0,0,0,0.4);
    }
    .bb-feature-card--active {
        background: var(--bb-accent-soft);
        border-color: var(--bb-accent);
    }
    .bb-feature-icon {
        font-size: 3rem;
        color: var(--bb-accent);
        margin-bottom: 32px;
    }
    .bb-feature-title {
        font-family: var(--bb-font-display);
        font-size: 1.75rem;
        margin-bottom: 20px;
        color: #fff;
    }
    .bb-feature-text {
        color: var(--bb-text-muted);
        line-height: 1.8;
        font-size: 1rem;
    }

    @keyframes bbHeroPulse {
        from { transform: scale(1.05); }
        to { transform: scale(1.15); }
    }
</style>

<%@ include file="/components/user-footer.jsp" %>