# Bank of Georgia — Merchant Integration Guide

Complete guide to what the **merchant must build and register** to integrate BOG payment services.

---

## 1. Merchant-Side URL Requirements

All URLs must be **HTTPS** in production. Register these in the BOG developer portal.

### iPay (Card Payments)

| URL Parameter | Purpose | Example |
|---------------|---------|---------|
| `redirect_links.success` | Redirect after successful payment | `https://yourshop.com/payment/success` |
| `redirect_links.fail` | Redirect after payment failure | `https://yourshop.com/payment/failed` |
| `redirect_links.cancel` | Redirect if user cancels | `https://yourshop.com/payment/cancel` |
| Webhook URL (portal) | BOG POSTs order events (server-to-server) | `https://yourshop.com/webhooks/bog-ipay` |

> Redirect links are passed **per order** at creation time. Webhook URL is configured globally in `bonline.bog.ge`.

### Installment Loans (Direct API)

| URL Parameter | Purpose | Example |
|---------------|---------|---------|
| `callbackUrl` | BOG POSTs status updates (server-to-server) | `https://yourshop.com/installments/bog-callback` |
| `successRedirectUrl` | Redirect after successful installment | `https://yourshop.com/order/success` |
| `failRedirectUrl` | Redirect after rejection | `https://yourshop.com/order/failed` |

### PSD2 / Open Banking (OAuth2)

| URL | Purpose | Example |
|-----|---------|---------|
| `redirect_uri` | OAuth2 authorization code return | `https://yourshop.com/oauth/bog/callback` |

Must be pre-registered at `https://api.bog.ge` developer portal.

---

## 2. Callback / Webhook Endpoint Requirements

Your callback endpoint must:

- **Return HTTP 200** within 10 seconds or BOG will retry
- **Be idempotent** — the same callback may be delivered multiple times
- **Accept POST** with `Content-Type: application/json`
- **Always respond 200** even for unrecognized events
- **Not block** on long operations — queue and respond immediately

### iPay Webhook Payload

```json
{
  "event": "order.success",
  "order_id": "ipay-order-abc",
  "shop_order_id": "YOUR-ORDER-123",
  "status": "SUCCESS",
  "amount": 301.00,
  "currency": "GEL",
  "zoned_request_time": "2023-06-15T10:30:00+04:00"
}
```

**Event types:**
- `order.success` — Payment completed
- `order.failed` — Payment failed
- `order.refunded` — Refund processed
- `order.expired` — Order expired without payment

**Express handler:**
```javascript
app.post('/webhooks/bog-ipay', express.json(), async (req, res) => {
  // 1. Respond immediately
  res.sendStatus(200);

  const { event, shop_order_id, status, order_id } = req.body;

  // 2. Idempotency check
  if (await db.eventExists(order_id, event)) return;
  await db.markEventProcessed(order_id, event);

  // 3. Handle event
  switch (event) {
    case 'order.success':
      await fulfillOrder(shop_order_id);
      break;
    case 'order.refunded':
      await processRefund(shop_order_id);
      break;
    case 'order.failed':
    case 'order.expired':
      await cancelOrder(shop_order_id);
      break;
  }
});
```

### Installments Callback Payload

```json
{
  "status": "success",
  "order_id": "bog-inst-abc123",
  "shop_order_id": "SHOP-ORDER-2023-001",
  "payment_method": "BOG_LOAN",
  "zoned_request_time": "2023-06-15T10:30:00+04:00",
  "event": "order_payment"
}
```

**Event types:**
- `order_payment` — Loan approved and disbursed
- `order_cancelled` — Order cancelled
- `order_reverse` — Refund/reversal initiated

**FastAPI handler (Python):**
```python
@app.post("/installments/bog-callback")
async def bog_installment_callback(payload: dict, background_tasks: BackgroundTasks):
    background_tasks.add_task(process_installment_event, payload)
    return Response(status_code=200)

async def process_installment_event(payload: dict):
    if await redis.exists(f"processed:{payload['order_id']}:{payload['event']}"):
        return
    await redis.setex(f"processed:{payload['order_id']}:{payload['event']}", 86400, "1")

    if payload["status"] == "success" and payload["event"] == "order_payment":
        await fulfill_order(payload["shop_order_id"])
```

---

## 3. OAuth2 Redirect Handler

After user authorizes at BOG, they are redirected to your `redirect_uri`:

```
GET /oauth/bog/callback?code=AUTH_CODE&state=RANDOM_STATE
```

**What to verify:**
1. `state` matches stored session value (CSRF protection)
2. Exchange `code` for tokens within ~60 seconds
3. Store tokens encrypted (never in plain text)

```python
@app.get("/oauth/bog/callback")
async def bog_oauth_callback(code: str, state: str, session: dict):
    # 1. CSRF check
    if state != session.get("bog_oauth_state"):
        raise HTTPException(403, "Invalid state — possible CSRF")

    # 2. Exchange code
    token = requests.post("https://api.bog.ge/auth/token",
        data={
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": BOG_REDIRECT_URI
        },
        auth=(BOG_CLIENT_ID, BOG_CLIENT_SECRET),
        headers={"Content-Type": "application/x-www-form-urlencoded"}
    ).json()

    # 3. Store securely
    await store_bog_tokens(session["user_id"], token)
    return RedirectResponse("/dashboard")
```

---

## 4. Environment Configuration

### Required Environment Variables

```env
# BOG iPay / Installment Credentials
BOG_CLIENT_ID=your_client_id
BOG_CLIENT_SECRET=your_client_secret

# For PSD2 Open Banking
BOG_PSD2_CLIENT_ID=your_psd2_client_id
BOG_PSD2_CLIENT_SECRET=your_psd2_secret

# Environment
BOG_ENV=sandbox   # or: production

# Your registered URLs
BOG_REDIRECT_URI=https://yourshop.com/oauth/bog/callback
BOG_IPAY_SUCCESS_URL=https://yourshop.com/payment/success
BOG_IPAY_FAIL_URL=https://yourshop.com/payment/failed
BOG_IPAY_CANCEL_URL=https://yourshop.com/payment/cancel
BOG_INSTALLMENT_CALLBACK_URL=https://yourshop.com/installments/bog-callback
BOG_INSTALLMENT_SUCCESS_URL=https://yourshop.com/order/success
BOG_INSTALLMENT_FAIL_URL=https://yourshop.com/order/failed
```

### Base URLs by Environment

```python
BOG_API = {
    "sandbox": "https://xs2a-sandbox.bog.ge",
    "production": "https://api.bog.ge"
}
BOG_IPAY = "https://ipay.ge"            # Same URL; test mode via credentials
BOG_INSTALLMENT = "https://installment.bog.ge/v1"
```

---

## 5. Security Requirements

| Requirement | Details |
|-------------|---------|
| HTTPS only | All callback/redirect URLs must use TLS 1.2+ |
| Webhook validation | BOG does not currently sign iPay webhooks — validate `shop_order_id` against your DB |
| State parameter | Always use random `state` in OAuth2 to prevent CSRF |
| Secret storage | Never hardcode — use env vars or a secrets manager |
| X-Request-ID | Generate unique UUID per request |
| Idempotency | Callbacks may be delivered multiple times — deduplicate by `order_id` + `event` |
| Amount validation | Always re-verify `amount` and `currency` against your order record |

> **Amount validation is critical:** Always compare callback `amount` to your stored order amount before fulfilling. Never trust the callback amount alone.

```python
def validate_callback(payload: dict, order: Order) -> bool:
    return (
        payload["shop_order_id"] == order.id and
        abs(float(payload["amount"]) - order.amount) < 0.01 and
        payload["currency"] == order.currency
    )
```

---

## 6. Payment Lifecycle & State Machine

```
[CREATED] → [PROCESSING] → [SUCCESS] → [REFUNDED / PARTIALLY_REFUNDED]
                          ↓
                        [FAILED]
                          ↓
                       [EXPIRED]
```

**Recommended order status mapping:**

| BOG Status | Your Order Status | Action |
|------------|------------------|--------|
| `CREATED` | `payment_pending` | Show "processing" to user |
| `PROCESSING` | `payment_processing` | Wait for callback |
| `SUCCESS` | `paid` | Fulfill order |
| `FAILED` | `payment_failed` | Notify customer, retry option |
| `EXPIRED` | `cancelled` | Release held inventory |
| `REFUNDED` | `refunded` | Process return |
| `PARTIALLY_REFUNDED` | `partially_refunded` | Update partial refund record |

---

## 7. Testing Checklist

Before going live, verify:

- [ ] Sandbox credentials obtained from `https://api.bog.ge` (developer portal)
- [ ] Or merchant credentials from `https://bonline.bog.ge`
- [ ] Callback/webhook URL is publicly accessible (use ngrok for local dev)
- [ ] Test full iPay checkout flow end-to-end
- [ ] Test installment checkout flow end-to-end
- [ ] Test webhook idempotency (send same payload twice)
- [ ] Validate `shop_order_id` and `amount` in callback handler
- [ ] Test refund flow
- [ ] Test expired order handling
- [ ] All URLs updated to production before go-live
- [ ] Production `client_id` / `client_secret` configured and tested
- [ ] SDK script updated to production `client_id` (if using BOG SDK)

---

## 8. Polling vs Callbacks

Use **both** strategies for reliability:

```python
# Scheduled job — reconcile orders stuck in pending
async def reconcile_pending_bog_orders():
    pending = await db.get_pending_orders(
        provider="bog",
        older_than_minutes=5
    )
    for order in pending:
        status = await bog_get_order_status(order.provider_order_id)
        if status["status"] != order.status:
            await handle_status_change(order, status["status"])
```

---

## 9. SDK Integration (Installments)

When using `BOG.SmartButton` / `BOG.Calculator`, your backend must expose an endpoint that the SDK calls:

```
POST /api/create-installment-order
Body: { amount, products, campaignId }
Response: { redirect_url }
```

```javascript
// Express endpoint called by BOG SDK
app.post('/api/create-installment-order', async (req, res) => {
  const { amount, products, campaignId } = req.body;

  const order = await bogCreateInstallmentOrder({
    amount,
    products,
    campaignId,
    invoiceId: generateInvoiceId(),
    callbackUrl: process.env.BOG_INSTALLMENT_CALLBACK_URL,
    successRedirectUrl: process.env.BOG_INSTALLMENT_SUCCESS_URL,
    failRedirectUrl: process.env.BOG_INSTALLMENT_FAIL_URL
  });

  res.json({ redirect_url: order.redirect_url });
});
```
