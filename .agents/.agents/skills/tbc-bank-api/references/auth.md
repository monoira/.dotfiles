# TBC Bank Authentication

## Authorization Types

| Type | Use Case | Header / Method | Where Used |
|------|----------|-----------------|------------|
| apikey | Application identification for public-facing APIs | `apikey: {key}` request header | Checkout (TPay), E-commerce |
| Client Credentials (OAuth 2.0) | Server-to-server access with no end-user context | POST to token endpoint with `grant_type=client_credentials` | Installments, Exchange Rates, Mortgage |
| Authorization Code (OAuth 2.0) | User-authorized access via redirect-based SCA | GET authorize endpoint, then POST token endpoint with `grant_type=authorization_code` | Open Banking AIS/PIS, TBC ID |
| Bearer Token | Accessing protected resources after authentication | `Authorization: Bearer {access_token}` header | All authenticated API calls |
| Certificate Based (mTLS) | Mutual TLS for PSD2 and Open API products | QWAC/QSEAL client certificates presented during TLS handshake | Open Banking, Installments, Exchange Rates |

---

## Checkout / TPay Access Token

Use this flow to obtain a Bearer token for TPay (Checkout) API calls. The token is valid for 24 hours.

### Request

```http
POST https://api.tbcbank.ge/v1/tpay/access-token
Content-Type: application/x-www-form-urlencoded
apikey: {your_api_key}

client_id={merchant_client_id}&client_secret={merchant_client_secret}
```

| Parameter | Location | Required | Description |
|-----------|----------|----------|-------------|
| `apikey` | Header | Yes | Your registered application API key |
| `client_id` | Body | Yes | Merchant client ID issued by TBC |
| `client_secret` | Body | Yes | Merchant client secret issued by TBC |

### Response (200 OK)

```json
{
  "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 86400
}
```

| Field | Type | Description |
|-------|------|-------------|
| `access_token` | string | JWT access token to use in subsequent API calls |
| `token_type` | string | Always `Bearer` |
| `expires_in` | integer | Token lifetime in seconds (86400 = 24 hours) |

### Error Response (400 Bad Request)

```json
{
  "error": "invalid_client",
  "error_description": "Client authentication failed"
}
```

A 400 error typically means an incorrect `client_id` or `client_secret`. Verify your credentials in the TBC developer portal.

### Usage

Include the token in all subsequent TPay API calls:

```http
POST https://api.tbcbank.ge/v1/tpay/payments
Authorization: Bearer {access_token}
apikey: {your_api_key}
Content-Type: application/json
```

---

## Open Banking / PSD2 (mTLS + OAuth 2.0)

PSD2 Open Banking endpoints require mutual TLS (mTLS) authentication. You must present a valid QWAC certificate during the TLS handshake for all token and resource requests.

### OpenID Configuration Discovery

Retrieve the full list of supported endpoints, grant types, scopes, and signing algorithms:

```http
GET https://api.tbcbank.ge/.well-known/openid-configuration
```

### User Authorization via Redirect SCA

Redirect the user's browser to the authorization endpoint to initiate Strong Customer Authentication (SCA):

```http
GET https://api.tbcbank.ge/psd2/openbanking/oauth/authorize
  ?response_type=code
  &client_id={tpp_client_id}
  &redirect_uri={your_callback_url}
  &scope=openid accounts payments
  &state={random_csrf_state}
  &code_challenge={pkce_challenge}
  &code_challenge_method=S256
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| `response_type` | Yes | Must be `code` |
| `client_id` | Yes | Your TPP client ID registered with TBC |
| `redirect_uri` | Yes | Pre-registered callback URL |
| `scope` | Yes | Space-separated scopes (e.g., `openid accounts payments`) |
| `state` | Recommended | Random string to prevent CSRF attacks |
| `code_challenge` | Recommended | PKCE challenge (S256) for added security |

After the user authenticates and consents, TBC redirects back to your `redirect_uri` with an authorization `code` and your `state` parameter.

### Client Initiated Backchannel Authentication (CIBA)

For decoupled authentication where the user approves on a separate device (e.g., mobile app):

```http
POST https://api.tbcbank.ge/psd2/openbanking/oauth/bc-authorization
Content-Type: application/x-www-form-urlencoded

scope=openid accounts
&client_id={tpp_client_id}
&login_hint={user_identifier}
&binding_message=Approve payment of 50 GEL
```

The response includes an `auth_req_id` that you poll against the token endpoint until the user completes authentication.

### Token Exchange (mTLS Required)

Exchange an authorization code or refresh token for an access token. A valid mTLS client certificate must be presented:

```http
POST https://api.tbcbank.ge/openbanking/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&code={authorization_code}
&redirect_uri={your_callback_url}
&client_id={tpp_client_id}
```

For refreshing tokens:

```http
POST https://api.tbcbank.ge/openbanking/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=refresh_token
&refresh_token={refresh_token}
&client_id={tpp_client_id}
```

For client credentials (server-to-server, used by Installments, Exchange Rates, etc.):

```http
POST https://api.tbcbank.ge/openbanking/oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&client_id={client_id}
&client_secret={client_secret}
```

### Token Response

```json
{
  "access_token": "eyJhbGciOiJQUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "dGhpcyBpcyBhIHJlZnJlc2ggdG9rZW4...",
  "scope": "openid accounts payments",
  "id_token": "eyJhbGciOiJQUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### JWKS for Token Verification

Retrieve TBC Bank's public keys to verify the signature of JWTs (access tokens and ID tokens):

```http
GET https://api.tbcbank.ge/.well-known/keys
```

```json
{
  "keys": [
    {
      "kty": "RSA",
      "kid": "key-id-1",
      "use": "sig",
      "alg": "PS256",
      "n": "...",
      "e": "AQAB"
    }
  ]
}
```

### User Info (mTLS Required)

Retrieve information about the authenticated user. A valid mTLS certificate and Bearer token are both required:

```http
GET https://api.tbcbank.ge/userinfo
Authorization: Bearer {access_token}
```

```json
{
  "sub": "user-unique-id",
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

## Certificates

### PSD2 APIs

PSD2 APIs (Account Information Service, Payment Initiation Service) require client certificates in both **test** and **production** environments. You cannot call these endpoints without a valid certificate.

### Open API Products

Open API products (Installments, E-commerce, Exchange Rates, Mortgage, TBC ID) require mTLS certificates for OAuth 2.0 token endpoints and resource access.

### Obtaining Certificates

Send an email to `developers@tbcbank.ge` with the following information:

- **Company name** and **identification code**
- **API product name** (e.g., AIS, PIS, Installments, E-commerce)
- **Environment** (test or production)

TBC will issue the appropriate certificate for your use case.

### Production Certificate Requirements

| Entity Type | Certificate Requirement |
|-------------|------------------------|
| Banks | Certificate from a trusted provider licensed by the National Bank of Georgia |
| FinTech / Microfinance | QWAC (Qualified Website Authentication Certificate) and QSeal (Qualified Electronic Seal) from an authorized eIDAS provider |

### Using Certificates in Requests

Example with cURL:

```http
curl --cert client.pem --key client-key.pem \
  -X POST https://api.tbcbank.ge/openbanking/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id={id}&client_secret={secret}"
```

---

## DBI (Direct Bank Integration) Authentication

The DBI integration service uses SOAP with WS-Security. Authentication requires three components:

- **Username** -- provided by TBC
- **Password** -- temporary password, must be changed on first use
- **Digital Certificate** -- `.pfx` client certificate and `.cer` root certificate

### Test Endpoint

```
https://secdbitst.tbconline.ge/dbi/dbiService
```

### SOAP Security Header Example (C#)

```csharp
[XmlRoot(Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
public partial class Security : SoapHeader
{
    public UsernameToken UsernameToken { get; set; }
}

public partial class UsernameToken
{
    public string Username { get; set; }
    public string Password { get; set; }
    public string Nonce { get; set; }
}
```

### Configuring the SOAP Client (C#)

```csharp
// Load the client certificate
var certificate = new X509Certificate2("client-certificate.pfx", "pfx-password");

// Create the binding with transport-level security
var binding = new BasicHttpsBinding();
binding.Security.Mode = BasicHttpsSecurityMode.Transport;
binding.Security.Transport.ClientCredentialType = HttpClientCredentialType.Certificate;

// Create the client and attach the certificate
var endpoint = new EndpointAddress("https://secdbitst.tbconline.ge/dbi/dbiService");
var client = new DbiServiceClient(binding, endpoint);
client.ClientCredentials.ClientCertificate.Certificate = certificate;

// Set the SOAP security header
var security = new Security
{
    UsernameToken = new UsernameToken
    {
        Username = "your-username",
        Password = "your-password",
        Nonce = Convert.ToBase64String(Guid.NewGuid().ToByteArray())
    }
};
```

### Required Files for DBI

| File | Format | Description |
|------|--------|-------------|
| Username | string | Provided by TBC Bank |
| Password | string | Temporary; must be changed after first login |
| Client certificate | `.pfx` | Digital certificate for mutual authentication |
| Root certificate | `.cer` | TBC Bank root CA certificate for trust validation |
