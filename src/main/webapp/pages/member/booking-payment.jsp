<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.bytebistro.booking.model.Booking" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../components/user-header.jsp" />

<%
    Booking booking = (Booking) request.getAttribute("booking");
    if (booking == null) {
        response.sendRedirect(request.getContextPath() + "/booking?error=Booking not found.");
        return;
    }
%>

<!-- Section: Page Header -->
<div class="bb-page-header">
    <h1 class="bb-page-title">Secure Your <span style="font-style: italic; color: var(--bb-accent);">Reservation</span></h1>
    <p class="bb-page-sub">Complete your payment to confirm your table. Your culinary journey awaits.</p>
</div>

<%-- Alerts --%>
<c:if test="${not empty requestScope.error}">
    <div class="bb-alert bb-alert--danger">
        <i class="fa-solid fa-circle-exclamation"></i>
            ${requestScope.error}
    </div>
</c:if>

<!-- Payment Layout -->
<div style="display: grid; grid-template-columns: 1fr 420px; gap: 32px; align-items: start;">

    <!-- Left Column: QR Code & Upload -->
    <div style="display: flex; flex-direction: column; gap: 32px;">

        <!-- QR Code Section -->
        <div class="bb-card" style="text-align: center;">
            <h3 class="bb-card-title">Scan to Pay</h3>
            <p style="color: var(--bb-text-muted); font-size: 0.9rem; margin-bottom: 24px; line-height: 1.6;">
                Scan the QR code below with your mobile banking or digital wallet app to complete the reservation deposit.
            </p>
            <div style="background: #fff; border-radius: var(--bb-radius-lg); padding: 24px; display: inline-block; margin-bottom: 24px;">
                <img src="${pageContext.request.contextPath}/assets/qr-code.png" alt="Payment QR Code"
                     style="width: 240px; height: 240px; display: block;" />
            </div>
            <div style="display: flex; justify-content: center; gap: 32px; margin-top: 8px;">
                <div style="text-align: center;">
                    <div style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-accent);">
                        Rs. 500.00
                    </div>
                    <div style="font-size: 0.75rem; color: var(--bb-text-muted); text-transform: uppercase; letter-spacing: 0.1em; margin-top: 4px;">
                        Deposit Amount
                    </div>
                </div>
            </div>
        </div>

        <!-- Upload Payment Proof -->
        <div class="bb-card">
            <h3 class="bb-card-title">Upload Payment Proof</h3>
            <p style="color: var(--bb-text-muted); font-size: 0.9rem; margin-bottom: 24px; line-height: 1.6;">
                After completing the payment, upload a screenshot or photo of your transaction as proof.
            </p>

            <form action="${pageContext.request.contextPath}/booking" method="post" enctype="multipart/form-data" id="paymentForm">
                <input type="hidden" name="action" value="uploadPayment" />
                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>" />

                <div style="background: var(--bb-surface-2); border: 2px dashed var(--bb-border); border-radius: var(--bb-radius-lg); padding: 48px 24px; text-align: center; cursor: pointer; transition: 0.3s ease; margin-bottom: 24px;"
                     id="dropZone"
                     onclick="document.getElementById('paymentProof').click();"
                     onmouseover="this.style.borderColor='var(--bb-accent)'"
                     onmouseout="this.style.borderColor='var(--bb-border)'">
                    <i class="fa-solid fa-cloud-arrow-up" style="font-size: 2.5rem; color: var(--bb-accent); margin-bottom: 16px; display: block;"></i>
                    <p style="font-size: 0.95rem; font-weight: 600; color: var(--bb-text); margin-bottom: 8px;">
                        Click to upload payment screenshot
                    </p>
                    <p style="font-size: 0.8rem; color: var(--bb-text-muted);">
                        Supports PNG, JPG, JPEG (Max 5MB)
                    </p>
                    <input type="file" id="paymentProof" name="paymentProof" accept="image/*"
                           style="display: none;" onchange="previewPaymentProof(this)" required />
                </div>

                <!-- Preview -->
                <div id="previewContainer" style="display: none; margin-bottom: 24px;">
                    <label class="bb-label">Preview</label>
                    <div style="position: relative; border-radius: var(--bb-radius); overflow: hidden; border: 1px solid var(--bb-border);">
                        <img id="proofPreview" src="" alt="Payment Proof Preview"
                             style="width: 100%; max-height: 300px; object-fit: contain; display: block; background: var(--bb-surface-2);" />
                        <button type="button" onclick="removePreview()"
                                style="position: absolute; top: 8px; right: 8px; background: var(--bb-danger); color: #fff; border: none; border-radius: 50%; width: 28px; height: 28px; cursor: pointer; font-size: 0.8rem; display: flex; align-items: center; justify-content: center;">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                    <p id="fileName" style="font-size: 0.8rem; color: var(--bb-text-muted); margin-top: 8px;"></p>
                </div>

                <button type="submit" class="bb-btn bb-btn--primary" style="width: 100%; padding: 16px; font-size: 1rem;" id="submitBtn">
                    <i class="fa-solid fa-shield-check"></i> Submit Payment Proof
                </button>
            </form>
        </div>

        <!-- Payment Instructions -->
        <div class="bb-card" style="border-color: var(--bb-accent-soft);">
            <h3 class="bb-card-title" style="margin-bottom: 16px;">
                <i class="fa-solid fa-circle-info" style="margin-right: 8px;"></i>Payment Guidelines
            </h3>
            <div style="display: flex; flex-direction: column; gap: 16px;">
                <div style="display: flex; gap: 16px; align-items: flex-start;">
                    <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--bb-accent-soft); color: var(--bb-accent); display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem; flex-shrink: 0;">1</div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.9rem; margin-bottom: 4px;">Scan the QR Code</div>
                        <div style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.5;">Open your mobile banking or e-wallet app and scan the QR code displayed above.</div>
                    </div>
                </div>
                <div style="display: flex; gap: 16px; align-items: flex-start;">
                    <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--bb-accent-soft); color: var(--bb-accent); display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem; flex-shrink: 0;">2</div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.9rem; margin-bottom: 4px;">Pay the Deposit</div>
                        <div style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.5;">Transfer exactly <strong style="color: var(--bb-accent);">Rs. 500.00</strong> as the reservation deposit.</div>
                    </div>
                </div>
                <div style="display: flex; gap: 16px; align-items: flex-start;">
                    <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--bb-accent-soft); color: var(--bb-accent); display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem; flex-shrink: 0;">3</div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.9rem; margin-bottom: 4px;">Upload Proof</div>
                        <div style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.5;">Take a screenshot of the successful transaction and upload it using the form above.</div>
                    </div>
                </div>
                <div style="display: flex; gap: 16px; align-items: flex-start;">
                    <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--bb-accent-soft); color: var(--bb-accent); display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.85rem; flex-shrink: 0;">4</div>
                    <div>
                        <div style="font-weight: 600; font-size: 0.9rem; margin-bottom: 4px;">Confirmation</div>
                        <div style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.5;">Our team will verify your payment and confirm your booking. The deposit is credited to your final bill.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right Column: Booking Summary Sidebar -->
    <aside style="display: flex; flex-direction: column; gap: 24px; position: sticky; top: 32px;">

        <!-- Booking Details Card -->
        <div class="bb-card" style="background: var(--bb-accent-soft); border-color: var(--bb-accent); position: relative; overflow: hidden;">
            <div style="position: absolute; top: -10px; right: -10px; opacity: 0.1; font-size: 5rem; transform: rotate(15deg);">
                <i class="fa-solid fa-receipt"></i>
            </div>
            <h3 class="bb-card-title" style="color: var(--bb-text); margin-bottom: 20px;">Booking Details</h3>

            <div style="display: flex; flex-direction: column; gap: 16px;">
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Reference</span>
                    <span style="font-family: var(--bb-font-mono); font-weight: 700; color: var(--bb-accent);">#BB-<%= booking.getBookingId() %></span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Table</span>
                    <span style="font-weight: 600;">T-<%= String.format("%02d", booking.getTableNumber()) %></span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Date</span>
                    <span style="font-weight: 600;"><%= booking.getBookingDate() %></span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Time</span>
                    <span style="font-weight: 600;"><%= booking.getBookingTime() %></span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Guests</span>
                    <span style="font-weight: 600;"><%= booking.getGuestCount() %> Guest<%= booking.getGuestCount() > 1 ? "s" : "" %></span>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.85rem;">
                    <span style="color: var(--bb-text-muted);">Capacity</span>
                    <span style="font-weight: 600;"><%= booking.getSeatingCapacity() %> Seats</span>
                </div>

                <div style="border-top: 1px solid rgba(255,255,255,0.1); padding-top: 16px; margin-top: 8px; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-weight: 700; color: #fff;">Deposit Required</span>
                    <span style="font-family: var(--bb-font-display); font-size: 1.5rem; font-weight: 700; color: var(--bb-accent);">Rs. 500.00</span>
                </div>
            </div>
        </div>

        <!-- Status Info -->
        <div class="bb-card" style="text-align: center;">
            <div style="width: 64px; height: 64px; border-radius: 50%; background: var(--bb-accent-soft); color: var(--bb-accent); display: flex; align-items: center; justify-content: center; font-size: 1.75rem; margin: 0 auto 16px;">
                <i class="fa-solid fa-hourglass-half"></i>
            </div>
            <h4 style="font-family: var(--bb-font-display); font-size: 1.1rem; margin-bottom: 8px;">Awaiting Payment</h4>
            <p style="font-size: 0.8rem; color: var(--bb-text-muted); line-height: 1.6;">
                Your table is reserved for <strong style="color: var(--bb-accent);">15 minutes</strong>. Please complete the payment to secure your booking.
            </p>
        </div>

        <!-- Security Note -->
        <div style="display: flex; gap: 12px; align-items: flex-start; padding: 16px; border-radius: var(--bb-radius); background: var(--bb-surface); border: 1px solid var(--bb-border);">
            <i class="fa-solid fa-lock" style="color: var(--bb-success); margin-top: 2px;"></i>
            <p style="font-size: 0.75rem; color: var(--bb-text-muted); line-height: 1.6;">
                Your payment information is handled securely. The deposit will be credited to your final dining bill.
            </p>
        </div>
    </aside>
</div>

<style>
    .bb-alert {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        border-radius: var(--bb-radius);
        font-size: 0.9rem;
        font-weight: 500;
        margin-bottom: 24px;
    }
    .bb-alert--danger {
        background: rgba(224, 92, 92, 0.1);
        border: 1px solid rgba(224, 92, 92, 0.3);
        color: var(--bb-danger);
    }
</style>

<script>
    function previewPaymentProof(input) {
        var preview = document.getElementById('proofPreview');
        var container = document.getElementById('previewContainer');
        var dropZone = document.getElementById('dropZone');
        var fileNameEl = document.getElementById('fileName');

        if (input.files && input.files[0]) {
            var file = input.files[0];

            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                alert('File size must be under 5MB.');
                input.value = '';
                return;
            }

            var reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                container.style.display = 'block';
                dropZone.style.display = 'none';
                fileNameEl.textContent = file.name + ' (' + (file.size / 1024).toFixed(1) + ' KB)';
            };
            reader.readAsDataURL(file);
        }
    }

    function removePreview() {
        document.getElementById('paymentProof').value = '';
        document.getElementById('previewContainer').style.display = 'none';
        document.getElementById('dropZone').style.display = 'block';
    }

    // Form submission validation
    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        var fileInput = document.getElementById('paymentProof');
        if (!fileInput.files || fileInput.files.length === 0) {
            alert('Please upload your payment proof before submitting.');
            e.preventDefault();
            return;
        }
    });
</script>

<jsp:include page="../../components/user-footer.jsp" />
