# TBC Online Installment Loans

Allows merchants to offer TBC installment loan products at checkout. Customer is redirected to TBC to complete the loan application.

---

## Base URLs

| Environment | URL |
|-------------|-----|
| Testing | `https://test-api.tbcbank.ge` |
| Production | `https://api.tbcbank.ge` |

Authentication: `Bearer {access_token}` (OAuth2 client credentials) and `apikey` header.

---

## Endpoints

### Create Application

```http
POST /v1/online-installments/applications
Authorization: Bearer {access_token}
Content-Type: application/json
apikey: {your-api-key}
```

```json
{
  "merchantKey": "your-merchant-key",
  "campaignId": "campaign-abc",
  "priceTotal": 1500.00,
  "products": [
    {
      "name": "Samsung TV 55\"",
      "price": 1500.00,
      "quantity": 1
    }
  ],
  "invoiceId": "YOUR-ORDER-123"
}
```

**Response (201 Created):**
```
Location: https://tbcbank.ge/installments/session/{session-id}
```

```json
{
  "sessionId": "abc-123-def-456"
}
```

Redirect the customer to the `Location` header URL. The customer completes the loan application on TBC's side.

---

### Cancel Application

```http
POST /v1/online-installments/applications/{session-id}/cancel
Authorization: Bearer {access_token}
apikey: {your-api-key}
```

Cancels a pending installment application. Use when the customer cancels the order on your side before TBC processes it.

---

### Confirm Application

```http
POST /v1/online-installments/applications/{session-id}/confirm
Authorization: Bearer {access_token}
apikey: {your-api-key}
```

Merchant-side confirmation after the loan has been approved by TBC. Required to finalize the installment and trigger disbursement.

---

### Get Application Status

```http
GET /v1/online-installments/applications/{session-id}/status
Authorization: Bearer {access_token}
apikey: {your-api-key}
```

**Response:**
```json
{
  "sessionId": "abc-123-def-456",
  "status": "Approved",
  "invoiceId": "YOUR-ORDER-123"
}
```

Possible statuses: `Pending`, `Approved`, `Confirmed`, `Canceled`, `Rejected`, `Expired`.

---

### Poll Status Changes (Merchant-Level)

```http
GET /v1/online-installments/merchant/applications/status-changes?merchantKey={key}&take={count}
Authorization: Bearer {access_token}
apikey: {your-api-key}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `merchantKey` | string | Your merchant identifier |
| `take` | integer | Number of status change records to retrieve |

Returns a batch of status changes across all applications for your merchant. Use this for periodic polling instead of checking each session individually.

---

### Sync Status Changes

```http
POST /v1/online-installments/merchant/applications/status-changes-sync
Authorization: Bearer {access_token}
apikey: {your-api-key}
```

Acknowledges received status changes so they are not returned again by the polling endpoint. Call this after you have processed the batch from `status-changes`.

---

## Go-Live Process

1. **Get credentials**: Email `merchant.support@tbcbank.ge` to request your `merchantKey` and `campaignId`.
2. **Integrate and test**: Use the test environment (`test-api.tbcbank.ge`) to create applications and verify the full flow.
3. **Submit test results**: Send two `sessionId` values to `developers@tbcbank.ge`:
   - One application that reached **COMPLETE** status
   - One application that reached **CANCELED** status
4. TBC reviews and enables production access.

---

## Error Responses

| HTTP Status | Meaning |
|-------------|---------|
| `400` | Missing or invalid parameters (e.g., no `merchantKey`, invalid `campaignId`) |
| `401` | Session expired or invalid authentication |
| `404` | Merchant not found — verify your `merchantKey` is correct |

```json
{
  "status": 400,
  "title": "Bad Request",
  "detail": "merchantKey is required"
}
```
