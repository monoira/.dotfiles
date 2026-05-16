# TBC Open Banking (PSD2)

Implements **NextGenPSD2 v1.3.6** framework. All connections require **mTLS** (mutual TLS with client certificate).

---

## Base URLs

| Environment | URL |
|-------------|-----|
| Development | `https://dev-openbanking.tbcbank.ge` |
| Production | `https://openbanking.tbcbank.ge` |

---

## TBC ID — OpenID Connect

TBC uses OpenID Connect for PSU (Payment Service User) authentication.

### Discovery Endpoint

```http
GET /.well-known/openid-configuration
```

Returns the standard OpenID Connect discovery document with authorization, token, and userinfo endpoint URLs.

### Authorization

Redirect the PSU to TBC's authorize endpoint:

```
GET /authorize?response_type=code&client_id={client_id}&redirect_uri={redirect_uri}&scope=openid%20accounts&state={state}
```

| Parameter | Description |
|-----------|-------------|
| `response_type` | Always `code` |
| `client_id` | Your registered TPP client ID |
| `redirect_uri` | Pre-registered callback URL |
| `scope` | `openid accounts` for AIS, `openid payments` for PIS |
| `state` | CSRF protection token |

### Token Exchange

```http
POST /token
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&code={auth_code}&redirect_uri={redirect_uri}&client_id={client_id}&client_secret={client_secret}
```

**Response:**
```json
{
  "access_token": "eyJ...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "dGhpcyBpcyBhIHJlZnJlc2g...",
  "id_token": "eyJ..."
}
```

### UserInfo

```http
GET /userinfo
Authorization: Bearer {access_token}
```

Returns PSU identity claims (name, personal number, etc.) based on granted scopes.

---

## Account Information Services (AIS)

Requires a valid consent and PSU authorization via TBC ID.

### Account Movements

```http
GET /v1/accounts/{account-id}/transactions
Authorization: Bearer {access_token}
X-Request-ID: {uuid}
Consent-ID: {consent-id}
```

| Parameter | Description |
|-----------|-------------|
| `dateFrom` | Start date (YYYY-MM-DD) |
| `dateTo` | End date (YYYY-MM-DD) |
| `bookingStatus` | `booked`, `pending`, or `both` |

**Pagination**: Maximum **700 transactions per page**. Use the `_links.next` URL from the response to retrieve subsequent pages.

### Statements (SOAP)

Account statements are delivered via SOAP through the DBI service (see DBI Setup below). This provides full bank statement documents in a structured format.

---

## Payment Initiation Services (PIS)

Payment initiation is handled via **SOAP** through the DBI (Direct Banking Interface) service, not REST.

### DBI Setup

1. **Contact your banker** at TBC to request DBI access and credentials.
2. Receive your DBI `username`, `password`, and certificate for mTLS.
3. Access the WSDL definition at: `https://tbcbank-developers.apigee.io` (documentation portal).

### Test Endpoint

```
https://secdbitst.tbconline.ge/dbi/dbiService
```

Use this endpoint with your test credentials to validate SOAP requests before going live.

### WSDL Location

The DBI WSDL and service documentation are hosted at:

```
https://tbcbank-developers.apigee.io
```

Contact TBC developer support for access to the portal and detailed SOAP operation definitions.

---

## mTLS Requirements

All Open Banking API calls must include a client certificate in the TLS handshake:

- Certificate must be issued by a qualified QTSP (Qualified Trust Service Provider) for production
- For development, TBC provides test certificates upon registration
- Configure your HTTP client with both the client certificate and private key

```javascript
const https = require('https');
const fs = require('fs');

const agent = new https.Agent({
  cert: fs.readFileSync('client-cert.pem'),
  key: fs.readFileSync('client-key.pem'),
  ca: fs.readFileSync('tbc-ca.pem')
});
```
