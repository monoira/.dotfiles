# TBC Checkout / TPay API

## API Base URLs

| Environment | Base URL                        |
|-------------|---------------------------------|
| Sandbox     | `https://test-api.tbcbank.ge`   |
| Production  | `https://api.tbcbank.ge`        |

All checkout endpoints follow the pattern `/v1/tpay/{resource}`.

---

## Authentication

### Get Access Token

**POST** `/v1/tpay/access-token`

Obtain a Bearer token for subsequent API calls. Tokens are valid for 24 hours.

**Headers**

| Header       | Value                             |
|--------------|-----------------------------------|
| `apikey`     | Your API key                      |
| `Content-Type` | `application/x-www-form-urlencoded` |

**Request Body** (form-urlencoded)

| Field          | Type   | Description        |
|----------------|--------|--------------------|
| `client_id`    | string | OAuth client ID    |
| `client_secret`| string | OAuth client secret|

**Response** `200 OK`

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6...",
  "token_type": "Bearer",
  "expires_in": 86400
}
```

Use the token in all subsequent requests:

```
Authorization: Bearer {access_token}
```

---

## Payments

### Create Payment

**POST** `/v1/tpay/payments`

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `Content-Type`  | `application/json`     |
| `apikey`        | Your API key           |

**Request Body**

```json
{
  "amount": {
    "currency": "GEL",
    "total": 100.00,
    "subtotal": 90.00,
    "tax": 5.00,
    "shipping": 5.00
  },
  "returnurl": "https://example.com/return",
  "callbackUrl": "https://example.com/callback",
  "preAuth": false,
  "language": "ka",
  "merchantPaymentId": "order-12345",
  "saveCard": false,
  "expirationMinutes": 10,
  "description": "Order #12345",
  "installmentProducts": [
    {
      "name": "Product A",
      "price": 50.00,
      "quantity": 1
    },
    {
      "name": "Product B",
      "price": 40.00,
      "quantity": 1
    }
  ],
  "methods": [5]
}
```

**Field Reference**

| Field                  | Type    | Required | Description                                                    |
|------------------------|---------|----------|----------------------------------------------------------------|
| `amount.currency`      | string  | Yes      | Currency code (`GEL`, `USD`, `EUR`)                            |
| `amount.total`         | number  | Yes      | Total payment amount                                           |
| `amount.subtotal`      | number  | No       | Subtotal before tax/shipping                                   |
| `amount.tax`           | number  | No       | Tax amount                                                     |
| `amount.shipping`      | number  | No       | Shipping cost                                                  |
| `returnurl`            | string  | Yes      | URL to redirect after payment                                  |
| `callbackUrl`          | string  | No       | Server-to-server notification URL                              |
| `preAuth`              | boolean | No       | `true` to hold funds without capturing                         |
| `language`             | string  | No       | UI language (`ka`, `en`)                                       |
| `merchantPaymentId`    | string  | No       | Your internal order identifier                                 |
| `saveCard`             | boolean | No       | `true` to save card for recurring payments                     |
| `expirationMinutes`    | integer | No       | Payment link lifetime in minutes (max **12**)                  |
| `description`          | string  | No       | Short description shown to customer (max **30** characters)    |
| `installmentProducts`  | array   | No       | Product list for installment payments                          |
| `methods`              | array   | No       | Allowed payment method IDs                                     |

**Response** `200 OK`

```json
{
  "payId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "Created",
  "links": [
    {
      "uri": "https://api.tbcbank.ge/v1/tpay/payments/a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "method": "GET",
      "rel": "self"
    },
    {
      "uri": "https://checkout.tbcbank.ge/pay/a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "method": "REDIRECT",
      "rel": "approval_url"
    }
  ]
}
```

Redirect the customer to the `approval_url` link to complete payment.

---

### Get Payment Details

**GET** `/v1/tpay/payments/{payId}`

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `apikey`        | Your API key           |

**Response** `200 OK`

```json
{
  "payId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "Succeeded",
  "currency": "GEL",
  "amount": 100.00,
  "confirmedAmount": 100.00,
  "returnedAmount": 0,
  "paymentMethod": "CARD",
  "rrn": "123456789012",
  "recurringCard": {
    "recId": "rec-xxxx-xxxx"
  },
  "resultCode": "approved",
  "operationType": "Payment"
}
```

**Response Fields**

| Field              | Type   | Description                                      |
|--------------------|--------|--------------------------------------------------|
| `payId`            | string | Unique payment identifier                        |
| `status`           | string | Current payment status (see table below)         |
| `currency`         | string | Payment currency                                 |
| `amount`           | number | Requested payment amount                         |
| `confirmedAmount`  | number | Amount actually captured                         |
| `returnedAmount`   | number | Amount refunded                                  |
| `paymentMethod`    | string | Method used (e.g., `CARD`, `QR`)                 |
| `rrn`              | string | Retrieval Reference Number from the acquirer      |
| `recurringCard`    | object | Present if card was saved; contains `recId`      |
| `resultCode`       | string | Transaction result code (see Result Codes below) |
| `operationType`    | string | Type of operation performed                      |

**Payment Statuses**

| Status             | Description                                      |
|--------------------|--------------------------------------------------|
| `Created`          | Payment created, awaiting customer action        |
| `Processing`       | Payment is being processed                       |
| `Succeeded`        | Payment completed successfully                   |
| `Failed`           | Payment failed                                   |
| `Expired`          | Payment link expired before completion           |
| `WaitingConfirm`   | Pre-authorized, awaiting completion/capture      |
| `Returned`         | Full refund issued                               |
| `PartialReturned`  | Partial refund issued                            |

---

### Cancel / Refund Payment

**POST** `/v1/tpay/payments/{payId}/cancel`

Cancel a payment or issue a full/partial refund.

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `Content-Type`  | `application/json`     |
| `apikey`        | Your API key           |

**Request Body** (optional for partial refund)

```json
{
  "amount": 25.00
}
```

If `amount` is omitted, the full payment amount is refunded.

**Response** `200 OK`

```json
{
  "payId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "Returned",
  "returnedAmount": 25.00
}
```

**Important notes:**

- Partial cancellation can be performed **once per day** on the **same day** as the original transaction.
- For split payments, use the `extra` and `extra2` fields to specify how the refund is distributed among sub-merchants.

---

### Complete Pre-Authorized Payment

**POST** `/v1/tpay/payments/{payId}/completion`

Capture a previously pre-authorized payment.

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `Content-Type`  | `application/json`     |
| `apikey`        | Your API key           |

**Request Body**

```json
{
  "amount": 80.00
}
```

**Constraints:**

- The completion `amount` must be **less than or equal to** the original pre-authorized amount.
- Pre-authorized payments must be completed within **30 days**. After 30 days, the hold is automatically released.

**Response** `200 OK`

```json
{
  "payId": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "status": "Succeeded",
  "confirmedAmount": 80.00
}
```

---

## Recurring Payments

### Execute Recurring Payment

**POST** `/v1/tpay/payments/execution`

Charge a previously saved card using its `recId`.

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `Content-Type`  | `application/json`     |
| `apikey`        | Your API key           |

**Request Body**

```json
{
  "recId": "rec-xxxx-xxxx",
  "money": {
    "currency": "GEL",
    "amount": 50.00
  },
  "preAuth": false,
  "initiator": "merchant"
}
```

| Field       | Type    | Required | Description                                          |
|-------------|---------|----------|------------------------------------------------------|
| `recId`     | string  | Yes      | Recurring card identifier from a saved-card payment  |
| `money`     | object  | Yes      | Currency and amount to charge                        |
| `preAuth`   | boolean | No       | `true` to pre-authorize instead of capture           |
| `initiator` | string  | No       | Who initiated: `merchant` or `customer`              |

**Response** `200 OK`

```json
{
  "payId": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
  "status": "Succeeded",
  "rrn": "987654321098"
}
```

### Delete Saved Card

**POST** `/v1/tpay/payments/{recId}/delete`

Remove a saved card so it can no longer be used for recurring payments.

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `apikey`        | Your API key           |

**Response** `200 OK`

```json
{
  "recId": "rec-xxxx-xxxx",
  "status": "Deleted"
}
```

---

## QR Payments (v2)

QR payments are available only in **GEL** currency and require a `terminalNo`.

### Create QR Payment

**POST** `/v2/tpay/qr`

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `Content-Type`  | `application/json`     |
| `apikey`        | Your API key           |

**Request Body**

```json
{
  "terminalNo": "TERMINAL001",
  "amount": 15.50,
  "currency": "GEL",
  "description": "Coffee order",
  "merchantPaymentId": "qr-order-001",
  "callbackUrl": "https://example.com/qr-callback"
}
```

**Response** `200 OK`

```json
{
  "payId": "c3d4e5f6-a7b8-9012-cdef-123456789012",
  "status": "Created",
  "qrCodeUrl": "https://checkout.tbcbank.ge/qr/c3d4e5f6-a7b8-9012-cdef-123456789012"
}
```

### Get QR Payment Status

**GET** `/v2/tpay/qr/{payId}`

**Headers**

| Header          | Value                  |
|-----------------|------------------------|
| `Authorization` | `Bearer {access_token}`|
| `apikey`        | Your API key           |

**Response** `200 OK`

```json
{
  "payId": "c3d4e5f6-a7b8-9012-cdef-123456789012",
  "status": "Succeeded",
  "amount": 15.50,
  "currency": "GEL"
}
```

---

## Callback IP Whitelist

When receiving server-to-server callbacks, validate that the request originates from one of the following TBC Bank IP addresses:

| IP Address       |
|------------------|
| `193.104.20.44`  |
| `193.104.20.45`  |
| `185.52.80.44`   |
| `185.52.80.45`   |

Reject any callback requests that do not come from these addresses.

---

## Result Codes

| Code                           | Description                                    |
|--------------------------------|------------------------------------------------|
| `approved`                     | Transaction approved                           |
| `decline_general`              | General decline by the issuer                  |
| `decline_expired_card`         | Card is expired                                |
| `decline_suspected_fraud`      | Declined due to suspected fraud                |
| `decline_restricted_card`      | Card is restricted by the issuer               |
| `decline_invalid_card_number`  | Invalid card number provided                   |
| `decline_not_sufficient_funds` | Insufficient funds on the card                 |
| `decline_card_not_effective`   | Card is not yet effective (future start date)  |
| `check_with_acquirer`          | Issuer requests contact with acquirer          |
