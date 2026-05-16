# Bank of Georgia Installment Loans

Two integration methods: **JavaScript SDK** (recommended for e-commerce frontend) or **Direct API**.

---

## Method 1: JavaScript SDK (BOG.Calculator + BOG.SmartButton)

Best for e-commerce product pages with a "Buy on installments" button.

### Setup

Add the SDK script to your HTML:

```html
<script src="https://webstatic.bog.ge/bog-sdk/bog-sdk.js?version=2&client_id={YOUR_CLIENT_ID}"></script>
```

### BOG.Calculator — Installment Modal

Opens a modal showing available installment plans for a given amount.

```javascript
// On button click or "Show installment options":
BOG.Calculator.open({
  amount: 1500,           // Total price in GEL
  bnpl: undefined,        // undefined = show both BNPL and loan options
                          // true = BNPL only, false = loan only

  onClose: function() {
    // User dismissed modal without selecting
    console.log('Modal closed');
  },

  onRequest: function(selectedPlan, successCallback, closeCallback) {
    // User selected a plan — create the order on your backend
    // selectedPlan contains: { months, amount, discount_code }

    fetch('/api/create-installment-order', {
      method: 'POST',
      body: JSON.stringify({
        amount: 1500,
        products: [{ name: 'Samsung TV', price: 1500, quantity: 1 }],
        campaignId: selectedPlan.discount_code
      }),
      headers: { 'Content-Type': 'application/json' }
    })
    .then(res => res.json())
    .then(order => {
      successCallback(order.redirect_url);  // SDK handles the redirect
    })
    .catch(() => {
      closeCallback();  // Close modal on error
    });
  },

  onComplete: function(redirectUrl) {
    // Payment flow done — redirect to thank-you page or use redirectUrl
    window.location.href = redirectUrl || '/order/success';
  }
});
```

### BOG.SmartButton — Inline Button Component

Renders a BOG-styled "Pay on installments" button:

```javascript
const container = document.getElementById('installment-btn-container');

BOG.SmartButton.render(container, {
  text: 'Buy on Installments',
  amount: 1500,
  onClick: function() {
    BOG.Calculator.open({
      amount: 1500,
      onRequest: function(plan, success, close) {
        // ... same as above
      }
    });
  }
});
```

---

## Method 2: Direct API Integration

For backend-initiated installment orders without the SDK.

### Registration

1. Register at `bonline.bog.ge`
2. Fill API registration form → receive `client_id` and `secret_key`
3. Test in sandbox, then go live

### Create Installment Order

```http
POST /v1/installment/orders
Host: installment.bog.ge
Authorization: Bearer {access_token}
Content-Type: application/json
```

```json
{
  "amount": 1500.00,
  "campaignId": "ZERO_INSTALLMENT_12",
  "invoiceId": "SHOP-ORDER-2023-001",
  "products": [
    {
      "name": "Samsung Galaxy S23",
      "price": 1500.00,
      "quantity": 1
    }
  ],
  "callbackUrl": "https://yourshop.com/installment/callback",
  "successRedirectUrl": "https://yourshop.com/order/success",
  "failRedirectUrl": "https://yourshop.com/order/fail"
}
```

**Response:**
```json
{
  "order_id": "bog-inst-abc123",
  "redirect_url": "https://installment.bog.ge/checkout/bog-inst-abc123",
  "status": "created"
}
```

Redirect customer: `window.location.href = response.redirect_url`

### Check Order Status

```http
GET /v1/installment/checkout/{orderId}
Authorization: Bearer {access_token}
```

**Response:**
```json
{
  "order_id": "bog-inst-abc123",
  "status": "success",
  "installment_status": "success",
  "ipay_payment_id": "ipay-xyz",
  "shop_order_id": "SHOP-ORDER-2023-001",
  "payment_method": "BOG_LOAN"
}
```

**Status values:**
- `success` — Loan approved and disbursed
- `in_progress` — Application being processed
- `error` — Application failed
- `reject` — Loan rejected

**installment_status values:**
- `success` — All good
- `reject` — BOG rejected loan
- `reverse_success` — Refund/reversal completed
- `fail` — Technical failure

### Get Available Installment Plans

```http
GET /v1/installment/discounts
  ?amount=1500
Authorization: Bearer {access_token}
```

**Response:**
```json
[
  { "month": 3, "amount": "510.00", "discount_code": "ZERO" },
  { "month": 6, "amount": "257.50", "discount_code": "ZERO" },
  { "month": 12, "amount": "130.00", "discount_code": "STANDARD" },
  { "month": 24, "amount": "68.00", "discount_code": "STANDARD" }
]
```

### Callback Handling

BOG POSTs to your `callbackUrl` on status changes:

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
- `order_payment` — Payment completed
- `order_cancelled` — Order cancelled
- `order_reverse` — Refund/reversal

```python
@app.post('/installment/callback')
def installment_callback():
    data = request.json
    if data['status'] == 'success' and data['event'] == 'order_payment':
        fulfill_order(data['shop_order_id'])
    return '', 200  # Must return 200
```

---

## Installment Integration Process

1. Register at `bonline.bog.ge` → get `client_id` + `secret_key`
2. Choose integration method (SDK or direct API)
3. Test in sandbox — perform at least one test transaction
4. Update website to show installment information for products
5. Replace test credentials with production credentials
6. Go live
