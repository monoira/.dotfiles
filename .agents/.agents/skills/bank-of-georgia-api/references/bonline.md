# BOG Business Online (BOnline) API

API for corporate banking: transfers, statements, exchange rates, document signing.

**Base URL:** `https://api.businessonline.ge/api`

## Authentication

### Token Auth (Server-to-Server)

```http
POST https://account.bog.ge/auth/realms/bog/protocol/openid-connect/token
Authorization: Basic {base64(client_id:client_secret)}
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
```

### Web Auth (User Context)

```
GET https://account.bog.ge/auth/realms/bog/protocol/openid-connect/auth
  ?client_id={client_id}
  &response_type=code
  &scope=corp
  &redirect_uri={your_redirect_uri}
  &kc_locale=ka
```

---

## Domestic Transfers

```http
POST /api/documents/domestic
Authorization: Bearer {token}
Content-Type: application/json
```

```json
{
  "Nomination": "Invoice payment #001",
  "ValueDate": "2024-01-15",
  "Amount": 500.00,
  "Currency": "GEL",
  "SourceAccountNumber": "GE50BG0000000001234567",
  "BeneficiaryAccountNumber": "GE99XX0000000000000001",
  "BeneficiaryBankCode": "BAGAGE22",
  "DocumentNo": "DOC001",
  "BeneficiaryInn": "01234567890",
  "BeneficiaryName": "Vendor Ltd",
  "DispatchType": "MT103",
  "IsSalary": false,
  "CheckInn": true
}
```

**Key parameters:**
- `Nomination` — Purpose (max 250 chars)
- `DispatchType` — `BULK` (max 10,000 GEL) or `MT103` (individual)
- `IsSalary` — `true` for salary payments
- `CheckInn` — Verify INN matches account holder

**Response:**
```json
[{ "UniqueId": "guid", "UniqueKey": 2, "ResultCode": 1, "Match": 1.0 }]
```

### Bulk Domestic Transfers

```http
POST /api/documents/bulk-domestic
```
Same structure, supports array of documents.

---

## Foreign Transfers

```http
POST /api/documents/foreign
Authorization: Bearer {token}
Content-Type: application/json
```

Additional parameters vs domestic:
- `Charges` — `SHA` (sender pays bank fees) or `OUR` (sender pays all)
- `BeneficiaryBankName` or `BeneficiaryBankCode` (SWIFT)
- `IntermediaryBankCode/Name` (optional)
- `PaymentDetail` — Purpose (max 4×34 chars)
- `BeneficiaryRegistrationCountryCode`, `BeneficiaryActualCountryCode`
- `RecipientAddress`, `RecipientCity` (optional)

---

## Account Statements

```http
GET /api/statement/{accountNumber}/{currency}/{id}/{page}
Authorization: Bearer {token}
```

**Response fields:** EntryDate, EntryAmount, EntryComment, SenderDetails, BeneficiaryDetails, DocumentDetails (TreasuryCode, Nomination, Rate)

---

## Exchange Rates

### Commercial Rates
```http
GET /api/rates/commercial/{currency}
```
Response: `{ "Sell": 2.5, "Buy": 2.6 }`

### NBG Official Rates
```http
GET /api/rates/nbg/{currency}
```
Response: Single decimal (e.g., `2.6450`)

---

## Document Signing (OTP)

### Request OTP
```http
POST /api/otp/request
Content-Type: application/json

{ "ObjectKey": "document_guid", "ObjectType": "document" }
```

### Sign Document
```http
POST /api/sign/document
Content-Type: application/json

{ "ObjectKey": "document_guid", "Otp": "123456" }
```

---

## Document Statuses

| Code | Meaning |
|------|---------|
| `C` | Cancelled by user |
| `N` | Incomplete |
| `D` | Cancelled by bank |
| `P` | Executed |
| `A` | Ready for signing |
| `S` | Signed |
| `T` | Processing |
| `R` | Rejected |
| `Z` | In signing process |

## Common Result Codes

| Code | Meaning |
|------|---------|
| 1 | Success |
| -1 | General error |
| -2 | Invalid account |
| -3 | Insufficient funds |
| -4 | Account blocked |
| -5 | Invalid currency |
| -10 | Document already exists |
| -20 | Invalid INN |
| -30 | Amount exceeds limit |

---

## Registration

1. Go to `bonline.bog.ge/admin/api`
2. Register application → receive `client_id`, `client_secret`, `redirect_uri`
3. Test in sandbox environment
4. Go live after bank approval
