<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../components/user-header.jsp" />

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">The <span style="font-style: italic; color: var(--bb-accent);">Heritage</span></h1>
    <p class="bb-page-sub">Unveiling the narrative behind ByteBistro's commitment to culinary excellence.</p>
</div>

<div style="display: grid; grid-template-columns: 1.2fr 1fr; gap: 60px; align-items: center; margin-bottom: 80px;">
    <div>
        <span style="color: var(--bb-accent); font-weight: 700; text-transform: uppercase; letter-spacing: 0.2em; font-size: 0.75rem;">OUR STORY</span>
        <h2 style="font-family: var(--bb-font-display); font-size: 2.75rem; margin-top: 16px; margin-bottom: 24px; font-style: italic;">Crafting Narratives<br>On Every Plate</h2>
        <p style="color: var(--bb-text-muted); font-size: 1.1rem; line-height: 1.8; margin-bottom: 24px;">
            ByteBistro was founded with a singular vision: to transform the traditional dining experience into a curated "Culinary Editorial." We believe that a meal is more than just sustenance; it's a chapter in a story shared between friends, family, and our dedicated team of chefs.
        </p>
        <p style="color: var(--bb-text-muted); font-size: 1.1rem; line-height: 1.8;">
            From our humble beginnings as a boutique kitchen to our current standing as a benchmark for sophisticated gastronomy, our mission remains unchanged: to bring people together through extraordinary food and unparalleled atmosphere.
        </p>
    </div>
    <div class="bb-card" style="padding: 0; overflow: hidden; border-radius: var(--bb-radius-lg); position: relative;">
        <div style="position: absolute; inset: 0; background: linear-gradient(to bottom, transparent, rgba(0,0,0,0.4)); z-index: 1;"></div>
        <img src="https://images.unsplash.com/photo-1559339352-11d035aa65de?auto=format&fit=crop&w=800&q=80" 
             style="width: 100%; height: 500px; object-fit: cover;" alt="Chef at work">
    </div>
</div>

<div class="bb-card" style="background: var(--bb-surface-2); padding: 60px;">
    <div style="text-align: center; margin-bottom: 48px;">
        <h2 style="font-family: var(--bb-font-display); font-size: 2.5rem; margin-bottom: 16px; font-style: italic;">Our Core Values</h2>
        <div style="width: 60px; height: 2px; background: var(--bb-accent); margin: 0 auto;"></div>
    </div>
    
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 40px;">
        <div style="text-align: center;">
            <div style="font-size: 2.5rem; color: var(--bb-accent); margin-bottom: 20px;"><i class="fa-solid fa-leaf"></i></div>
            <h3 style="font-family: var(--bb-font-display); font-size: 1.4rem; color: #fff; margin-bottom: 12px;">Purity</h3>
            <p style="color: var(--bb-text-muted); line-height: 1.6; font-size: 0.9rem;">We source only the finest, unadulterated seasonal ingredients from local ethical farms.</p>
        </div>
        <div style="text-align: center;">
            <div style="font-size: 2.5rem; color: var(--bb-accent); margin-bottom: 20px;"><i class="fa-solid fa-heart-pulse"></i></div>
            <h3 style="font-family: var(--bb-font-display); font-size: 1.4rem; color: #fff; margin-bottom: 12px;">Passion</h3>
            <p style="color: var(--bb-text-muted); line-height: 1.6; font-size: 0.9rem;">Our team is driven by a profound love for the culinary arts and a devotion to precision.</p>
        </div>
        <div style="text-align: center;">
            <div style="font-size: 2.5rem; color: var(--bb-accent); margin-bottom: 20px;"><i class="fa-solid fa-users-viewfinder"></i></div>
            <h3 style="font-family: var(--bb-font-display); font-size: 1.4rem; color: #fff; margin-bottom: 12px;">Community</h3>
            <p style="color: var(--bb-text-muted); line-height: 1.6; font-size: 0.9rem;">We foster an inclusive space where culinary exploration becomes a shared human experience.</p>
        </div>
    </div>
</div>

<jsp:include page="../../components/user-footer.jsp" />