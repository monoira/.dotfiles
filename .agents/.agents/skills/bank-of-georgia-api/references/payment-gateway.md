# BOG Payment Gateway (Billing / Service Provider)

For service providers integrating as BOG billing partners (utility, telecom, etc.). Different from iPay — this is for accepting payments through BOG's interfaces on behalf of your customers.

## Authentication Methods

### HTTP Basic Auth
```http
Authorization: Basic {base64(client_id:secret_key)}
```

### OAuth 2.0 Client Credentials
```http
POST {service_provider_endpoint}
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&client_id={client_id}
&client_secret={client_secret}
```
Response: `{ "access_token": "...", "expires_in": 3600, "token_type": "Bearer" }`

### API Key
```http
Auth-Key: {API_KEY}
```

### HMAC-SHA256
```http
Hash: {HMAC_SHA256_HASH}
```
- For POST/PATCH: hash the request body
- For GET/PUT/DELETE: hash the query string
- Output: uppercase hex string

---

## Predefined Operations

### Payment

```http
POST {endpoint}
Content-Type: application/json
```

```json
{
  "transactionId": "unique_transaction_id",
  "amount": 500000,
  "currency": "GEL",
  "parameters": {
    "personalNumber": "01234567890",
    "birthDate": "11.01.2002"
  }
}
```

**Response:**
```json
{
  "status": { "code": 0, "value": "OK" },
  "timestamp": 1693236686855,
  "receiptId": "1234"
}
```

### Transaction Status

```http
GET {endpoint}?transactionId={id}
```

Status codes: `12` (successful), `13` (failed), `14` (in progress)

### Cancel Payment

```http
GET {endpoint}?transactionId={id}
```

---

## Error Codes

| Code | Meaning |
|------|---------|
| 0 | OK |
| 1 | Access Denied |
| 2 | Invalid credentials |
| 3 | Invalid hash |
| 4 | Missing parameter |
| 5 | Invalid parameter |
| 6 | Customer does not exist |
| 7 | Invalid amount |
| 8 | Payment not unique |
| 9 | Payment not possible |
| 10 | Unknown service |
| 11 | Unknown operation type |
| 12 | Successful transaction |
| 13 | Invalid transaction |
| 14 | Transaction in progress |
| 99 | General error |

---

## Error Flow Scenarios

- **Access Denied (1):** Check credentials or hash
- **Customer Not Found (6):** Verify personalNumber/subscriber ID
- **Invalid Amount (7):** Check amount format and limits
- **Payment Not Unique (8):** transactionId already used
- **Payment Not Possible (9):** Insufficient balance or service unavailable
