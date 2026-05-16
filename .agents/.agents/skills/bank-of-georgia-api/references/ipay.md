# Bank of Georgia iPay Payment Gateway

iPay is BOG's hosted payment page solution for e-commerce.

## Authentication

Uses JWT Bearer tokens from the OAuth2 client credentials flow. See `auth.md`.

```http
Authorization: Bearer {jwt_token}
```

## Create Order / Checkout Session

```http
POST /api/checkout/orders
Host: ipay.ge
Authorization: Bearer {jwt_token}
Content-Type: application/json
```

```json
{
  "intent": "AUTHORIZE",
  "items": [
    {
      "unit_price": 150.50,
      "quantity": 2,
      "description": "Product Name"
    }
  ],
  "locale": "en",
  "shop_order_id": "YOUR-ORDER-123",
  "payment_method": ["card", "google_pay", "apple_pay", "bog_p2p", "bnpl"],
  "config": {
    "loan": { "type": "INSTALLMENT_0", "month": 12 },
    "campaign": { "card": "visa", "type": "restrict" }
  },
  "redirect_links": {
    "success": "https://yourshop.com/payment/success?order=YOUR-ORDER-123",
    "fail": "https://yourshop.com/payment/fail?order=YOUR-ORDER-123",
    "cancel": "https://yourshop.com/payment/cancel?order=YOUR-ORDER-123"
  },
  "show_shop_order_id_on_extract": true,
  "capture_method": "AUTOMATIC"
  
}
```

**Payment Methods:**
- `card` — Standard Visa/MC/Amex
- `google_pay` / `apple_pay`
- `bog_p2p` — Bank of Georgia P2P transfer
- `bog_loyalty` — MR/Plus points
- `bnpl` / `bog_loan` — Installments/Buy Now Pay Later
- `gift_card` — BOG Gift Cards

**Response:**
```json
{
  "id": "ipay-order-abc",
  "status": "CREATED",
  "redirect_links": {
    "checkout": "https://ipay.ge/checkout/ipay-order-abc"
  }
}
```

**Redirect the customer:**
```javascript
window.location.href = response.redirect_links.checkout;
```

## Get Order Status

```http
GET /api/checkout/orders/{orderId}
Authorization: Bearer {jwt_token}
```

**Response:**
```json
{
  "id": "ipay-order-abc",
  "status": "SUCCESS",
  "shop_order_id": "YOUR-ORDER-123",
  "payment_detail": {
    "amount": 301.00,
    "currency": "GEL",
    "payment_method": "CARD",
    "card": {
      "mask": "411111******1111",
      "expiry_date": "12/26",
      "brand": "VISA"
    }
  }
}
```

**Status values:**
- `CREATED` — Order created
- `PROCESSING` — Customer in checkout flow
- `SUCCESS` — Payment successful
- `FAILED` — Payment failed
- `REFUNDED` — Fully refunded
- `PARTIALLY_REFUNDED` — Partial refund
- `EXPIRED` — Order expired

## Pre-Authorization (Hold & Capture)

Use `"capture_method": "MANUAL"` in order creation to hold funds without immediate capture.

### Complete Pre-Auth

```http
POST /api/v1/checkout/payment/{order_id}/pre-auth/completion
Authorization: Bearer {jwt_token}
Content-Type: application/json
```

**Full capture:**
```json
{ "auth_type": "FULL_COMPLETE" }
```

**Partial capture:**
```json
{
  "auth_type": "PARTIAL_COMPLETE",
  "amount": "10.50"
}
```

**Cancel/void the hold:**
```json
{ "auth_type": "CANCEL" }
```

## Refunds

```http
POST /api/checkout/orders/{orderId}/refund
Authorization: Bearer {jwt_token}
Content-Type: application/json

{
  "amount": 50.00,
  "description": "Customer return"
}
```

## Recurring Payments / Card Tokenization

After first payment, save the card token for future charges:

```http
POST /api/checkout/orders
{
  "intent": "AUTHORIZE",
  "save_payment_method": true,
  ...
}
```

For subsequent charges using saved token:
```json
{
  "intent": "CHARGE",
  "payment_method_id": "pm_saved_card_token",
  "amount": 50.00
}
```

## Callbacks / Webhooks

BOG posts payment result to your configured webhook URL:

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

**Handle in Express:**
```javascript
app.post('/webhooks/ipay', express.json(), (req, res) => {
  const { event, shop_order_id, status } = req.body;

  if (event === 'order.success' && status === 'SUCCESS') {
    fulfillOrder(shop_order_id);
  }

  res.sendStatus(200); // Must acknowledge
});
```

## BOOnline Statements & Rates

For business accounts via BOOnline API:

```http
GET /api/statement/{accountNumber}/{currency}/{startDate}/{endDate}
GET /api/statement/v2/{accountNumber}/{currency}/{startDate}/{endDate}
GET /api/rates/nbg/{currency}/{startDate}/{endDate}
```

**Domestic payment document:**
```http
POST /api/documents/domestic
Authorization: Bearer {token}
Content-Type: application/json
```
