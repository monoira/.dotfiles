# TBC Merchant Integration Guide

Complete guide for merchants integrating TBC payment services: callbacks, dashboard, environment setup, and go-live requirements.

---

## 1. Callback Handling

TBC sends payment notifications via POST to your registered callback URL.

### Callback Payload

TBC POSTs a minimal payload:

```json
{
  "PaymentId": "tbc-payment-abc123"
}
```

Your handler must:
1. **Return HTTP 200** immediately (do not block on processing)
2. **GET the full payment details** from TBC using the `PaymentId`
3. **Update your order** based on the full status response

### Express.js Callback Handler

```javascript
const express = require('express');
const crypto = require('crypto');

// Track processed payments for idempotency
const processedPayments = new Set();

app.post('/webhooks/tbc-payment', express.json(), async (req, res) => {
  // 1. Always respond 200 immediately
  res.sendStatus(200);

  const { PaymentId } = req.body;
  if (!PaymentId) return;

  // 2. Idempotency check — skip if already processed
  if (processedPayments.has(PaymentId)) return;
  processedPayments.add(PaymentId);

  try {
    // 3. Fetch full payment details from TBC
    const details = await tbcClient.get(`/v1/tpay/payments/${PaymentId}`);

    // 4. Update your order based on status
    const order = await db.orders.findOne({ tbcPaymentId: PaymentId });
    if (!order) {
      console.error(`No order found for PaymentId: ${PaymentId}`);
      return;
    }

    await updateOrderStatus(order, details.status);
  } catch (err) {
    console.error(`Callback processing failed for ${PaymentId}:`, err);
    // Remove from processed set so it can be retried
    processedPayments.delete(PaymentId);
  }
});
```

> **Note**: In production, use a database-backed idempotency store instead of an in-memory `Set`.

---

## 2. IP Whitelist

TBC sends callbacks from these IP addresses. Whitelist them in your firewall:

| IP Address |
|------------|
| `193.104.20.44` |
| `193.104.20.45` |
| `185.52.80.44` |
| `185.52.80.45` |

```nginx
# nginx example
location /webhooks/tbc-payment {
    allow 193.104.20.44;
    allow 193.104.20.45;
    allow 185.52.80.44;
    allow 185.52.80.45;
    deny all;

    proxy_pass http://localhost:3000;
}
```

---

## 3. Dashboard

**URL**: `https://ecom.tbcpayments.ge`

**Login**: Use the company director's TBC Internet Banking credentials.

The dashboard provides:
- Transaction history and search
- Refund management
- Settlement reports
- API key management
- Callback URL configuration

---

## 4. Environment Configuration

```env
# .env — TBC Payment Integration

# API credentials
TBC_CLIENT_ID=your-client-id
TBC_CLIENT_SECRET=your-client-secret
TBC_API_KEY=your-api-key

# Environment URLs
TBC_API_BASE_URL=https://api.tbcbank.ge
TBC_AUTH_URL=https://api.tbcbank.ge/v1/tpay/access-token

# Merchant settings
TBC_MERCHANT_KEY=your-merchant-key
TBC_CAMPAIGN_ID=your-campaign-id

# Callback
TBC_CALLBACK_URL=https://yourshop.com/webhooks/tbc-payment
TBC_SUCCESS_REDIRECT=https://yourshop.com/payment/success
TBC_FAIL_REDIRECT=https://yourshop.com/payment/failed

# IP whitelist (for verification)
TBC_ALLOWED_IPS=193.104.20.44,193.104.20.45,185.52.80.44,185.52.80.45
```

---

## 5. Go-Live Requirements

Before TBC enables production access, your website must have the following **publicly accessible pages**:

| Requirement | Description |
|-------------|-------------|
| **Terms & Conditions** | Full terms of service for your shop |
| **Return Policy** | How customers can return products and get refunds |
| **Privacy Policy** | How you handle customer data (GDPR-aligned) |
| **Delivery Policy** | Shipping methods, timeframes, and costs |
| **Contact Information** | Company name, address, phone, email |

---

## 6. Testing Checklist

Before requesting production access, verify each item:

- [ ] Access token obtained successfully via client credentials
- [ ] Payment created and redirect URL works
- [ ] Customer can complete payment on TBC checkout page
- [ ] Callback received and returns HTTP 200
- [ ] Full payment details fetched after callback
- [ ] Order status updated correctly for successful payment
- [ ] Order status updated correctly for failed payment
- [ ] Refund initiated and callback processed
- [ ] IP whitelist configured (callbacks only from TBC IPs)
- [ ] Idempotency: duplicate callbacks do not create duplicate actions
- [ ] Error handling: graceful response to 4xx and 5xx errors
- [ ] Success and failure redirect pages render correctly
- [ ] All go-live pages (Terms, Privacy, etc.) are published

---

## 7. Payment Lifecycle

```
                     +----------+
                     |  Created |
                     +----+-----+
                          |
                    Customer redirected
                          |
                     +----v-----+
                     | Pending  |
                     +----+-----+
                          |
               +----------+----------+
               |                     |
          +----v-----+         +----v-----+
          | Approved |         | Declined |
          +----+-----+         +----------+
               |
          +----v-----+
          | Completed|
          +----+-----+
               |
          +----v-----+
          | Refunded | (partial or full)
          +----------+
```

Possible terminal states: `Completed`, `Declined`, `Cancelled`, `Expired`, `Refunded`.

---

## 8. Status Mapping

Map TBC payment statuses to your internal order statuses:

| TBC Status | Your Order Status | Action |
|------------|-------------------|--------|
| `Created` | `payment_pending` | Show "Waiting for payment" to customer |
| `Pending` | `payment_pending` | Customer is on TBC checkout — do nothing |
| `Approved` | `payment_authorized` | Payment authorized, prepare for fulfillment |
| `Completed` | `paid` | Payment captured — fulfill the order |
| `Declined` | `payment_failed` | Notify customer, offer retry |
| `Cancelled` | `cancelled` | Customer cancelled — release reserved stock |
| `Expired` | `payment_expired` | Session timed out — prompt customer to re-order |
| `Refunded` | `refunded` | Return funds confirmed — update accounting |
