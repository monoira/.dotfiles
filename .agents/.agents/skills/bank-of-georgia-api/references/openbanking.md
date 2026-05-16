# Bank of Georgia Open Banking (PSD2)

Base: `https://xs2a-sandbox.bog.ge/0.8/`

Implements PSD2 XS2A standard. All AIS endpoints require a valid consent.

## Account Information Services (AIS)

### Create Consent

```http
POST /0.8/psd2/v1/consents
Authorization: Bearer {token}
Content-Type: application/json
X-Request-ID: {uuid}
PSU-IP-Address: {ip}
```

```json
{
  "access": {
    "accounts": [{ "iban": "GE50BG0000000001234567" }],
    "balances": [{ "iban": "GE50BG0000000001234567" }],
    "transactions": [{ "iban": "GE50BG0000000001234567" }]
  },
  "recurringIndicator": true,
  "validTo": "2024-12-31",
  "frequencyPerDay": 4,
  "combinedServiceIndicator": false
}
```

**Response:**
```json
{
  "consentId": "consent-bog-xyz",
  "consentStatus": "received",
  "_links": {
    "scaRedirect": { "href": "https://..." },
    "scaOAuth": { "href": "https://api.bog.ge/.well-known/oauth-authorization-server" },
    "self": { "href": "/psd2/v1/consents/consent-bog-xyz" },
    "status": { "href": "/psd2/v1/consents/consent-bog-xyz/status" },
    "startAuthorisation": { "href": "/psd2/v1/consents/consent-bog-xyz/authorisations" }
  }
}
```

### Get Consent Status
```http
GET /0.8/psd2/v1/consents/{consentId}/status
X-Request-ID: {uuid}

Response: { "consentStatus": "valid" }
```

### Get Consent Authorisation Sub-Resources

```http
GET /0.8/psd2/v1/consents/{consentId}/authorisations
Authorization: Bearer {token}
X-Request-ID: {uuid}
```

Uses `consentId` path param (string): ID returned by the consent creation.

### List Accounts

```http
GET /0.8/v1/accounts
Authorization: Bearer {token}
Consent-ID: {consentId}
X-Request-ID: {uuid}
PSU-IP-Address: {ip}
```

**Response:**
```json
{
  "accounts": [
    {
      "resourceId": "acct-bog-abc",
      "iban": "GE50BG0000000001234567",
      "currency": "GEL",
      "ownerName": "John Doe",
      "product": "Current Account",
      "cashAccountType": "CACC",
      "status": "enabled",
      "_links": {
        "balances": { "href": "/0.8/v1/accounts/acct-bog-abc/balances" },
        "transactions": { "href": "/0.8/v1/accounts/acct-bog-abc/transactions" }
      }
    }
  ]
}
```

### Get Account Balances

```http
GET /0.8/v1/accounts/{accountId}/balances
Authorization: Bearer {token}
Consent-ID: {consentId}
X-Request-ID: {uuid}
```

### Get Transactions

```http
GET /0.8/v1/accounts/{accountId}/transactions
  ?dateFrom=2023-01-01
  &dateTo=2023-12-31
  &bookingStatus=booked
Authorization: Bearer {token}
Consent-ID: {consentId}
X-Request-ID: {uuid}
```

**Response:**
```json
{
  "account": { "iban": "GE50BG0000000001234567" },
  "transactions": {
    "booked": [
      {
        "transactionId": "txn-123",
        "creditorName": "Shop Name",
        "creditorAccount": { "iban": "GE..." },
        "transactionAmount": { "currency": "GEL", "amount": "-49.99" },
        "bookingDate": "2023-06-15",
        "valueDate": "2023-06-15",
        "remittanceInformationUnstructured": "Online purchase"
      }
    ],
    "pending": []
  }
}
```

## Payment Initiation Services (PIS)

### Payment Products

| Product | Description |
|---------|-------------|
| `sepa-credit-transfers` | SEPA standard transfers |
| `domestic` | Local GEL transfers |
| `aspsp` | BOG's own product (supports FX) |
| `instant` | Instant payment |
| `foreign` | Foreign currency transfers |

### Initiate Payment

```http
POST /0.8/psd2/v1/payments/{paymentProduct}
Authorization: Bearer {token}
Content-Type: application/json
X-Request-ID: {uuid}
PSU-IP-Address: {ip}
```

```json
{
  "debtorAccount": { "iban": "GE50BG0000000001234567" },
  "instructedAmount": { "currency": "GEL", "amount": "200.00" },
  "creditorAccount": { "iban": "GE99XX0000000000000001" },
  "creditorName": "Merchant Ltd",
  "remittanceInformationUnstructured": "Order #12345"
}
```

**Response (multiple authorization modes):**
```json
{
  "transactionStatus": "RCVD",
  "paymentId": "1234-wertiq-983",
  "_links": {
    "scaRedirect": { "href": "https://www.bog.ge/authorize/..." },
    "self": { "href": "/psd2/v1/payments/1234-wertiq-983" },
    "status": { "href": "/psd2/v1/payments/1234-wertiq-983/status" },
    "scaStatus": { "href": "/psd2/v1/payments/1234-wertiq-983/authorisations/123auth456" }
  }
}
```

For OAuth2 flow the response includes:
```json
{ "_links": { "scaOAuth": { "href": "https://api.bog.ge/.well-known/..." } } }
```

For embedded flow:
```json
{ "_links": { "startAuthorisationWithPsuAuthentication": { "href": "..." } } }
```

### Get Payment Status

```http
GET https://xs2a-sandbox.bog.ge/0.8/v1/{payment-service}/{payment-product}/{paymentId}/status
Host: xs2a-sandbox.bog.ge
X-Request-ID: 99391c7e-ad88-49ec-a2ad-99ddcb1f7721
PSU-IP-Address: 192.168.8.78
```

### Start Payment Authorization

```http
POST /0.8/psd2/v1/payments/{paymentProduct}/{paymentId}/authorisations
Authorization: Bearer {token}
X-Request-ID: {uuid}
PSU-IP-Address: {ip}
```

## Signing Baskets (Batch Authorization)

Authorize multiple payments in a single SCA:

```http
POST /0.8/psd2/v1/signing-baskets
Authorization: Bearer {token}
Content-Type: application/json
X-Request-ID: {uuid}

{
  "paymentIds": ["1234pay567", "1234pay568", "1234pay888"]
}
```

**Response:**
```json
{
  "transactionStatus": "RCVD",
  "basketId": "1234-basket-567",
  "_links": {
    "self": { "href": "/psd2/v1/signing-baskets/1234-basket-567" },
    "status": { "href": "/psd2/v1/signing-baskets/1234-basket-567/status" },
    "startAuthorisation": { "href": "/psd2/v1/signing-baskets/1234-basket-567/authorisations" }
  }
}
```

### Get Signing Basket
```http
GET /0.8/psd2/v1/signing-baskets/{basketId}
```

**Response:**
```json
{
  "payments": ["1234pay567", "1234pay568", "1234pay888"],
  "transactionStatus": "ACTC"
}
```

## Banking Products Catalog

```http
GET /0.8/banking/products/{locale}
Host: xs2a-sandbox.bog.ge
```

- `locale` values: `en`, `ka` (Georgian)
- Optional query params: `page`, `size` (pagination)

```http
GET /banking/products/{locale}/personal-loans
GET /banking/products/{locale}/business-loans
GET /banking/products/{locale}/deposits
```
