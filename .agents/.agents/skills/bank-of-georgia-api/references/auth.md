# Bank of Georgia Authentication

## OAuth2 Client Credentials (Backend)

For server-to-server requests (installments, banking products, iPay).

```http
POST /v1/oauth2/token
Host: api.bog.ge
Content-Type: application/x-www-form-urlencoded
Authorization: Basic {base64(client_id:client_secret)}

grant_type=client_credentials
&scope=payments accounts
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJSUzI1NiJ9...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "scope": "payments accounts"
}
```

## OAuth2 Authorization Code Flow (User Auth / PSD2)

For PSD2 Account Information and Payment Initiation that require user consent.

### Step 1: Authorization Request
```
GET https://api.bog.ge/auth/authorize
  ?response_type=code
  &client_id={client_id}
  &redirect_uri={redirect_uri}
  &scope=openid accounts payments
  &state={random_state}
  &nonce={random_nonce}
```

### Step 2: Token Exchange
```http
POST /auth/token
Host: api.bog.ge
Content-Type: application/x-www-form-urlencoded
Authorization: Basic {base64(client_id:secret)}

grant_type=authorization_code
&code={auth_code}
&redirect_uri={redirect_uri}
```

### Step 3: Token Response
```json
{
  "access_token": "eyJhbGci...",
  "id_token": "eyJhbGci...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "...",
  "scope": "openid accounts"
}
```

## Refresh Token

```http
POST /auth/token
Content-Type: application/x-www-form-urlencoded
Authorization: Basic {base64(client_id:secret)}

grant_type=refresh_token
&refresh_token={refresh_token}
```

## OAuth Discovery

```
GET https://api.bog.ge/.well-known/oauth-authorization-server
GET https://api.bog.ge/bogid/.well-known/openid-configuration
```

## User Info (BOG ID)

```http
GET https://api.bog.ge/bogid/userinfo
Authorization: Bearer {access_token}
```

**Response:**
```json
{
  "sub": "user-id-123",
  "name": "John Doe",
  "personalNumber": "PNOGE-00000000001",
  "phoneNumber": "+995 555 123456",
  "email": "john@example.com"
}
```

## Python Example

```python
import requests
import base64

client_id = "your_client_id"
client_secret = "your_client_secret"
credentials = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()

# Get access token
resp = requests.post(
    "https://api.bog.ge/v1/oauth2/token",
    data={"grant_type": "client_credentials"},
    headers={
        "Authorization": f"Basic {credentials}",
        "Content-Type": "application/x-www-form-urlencoded"
    }
)
token = resp.json()["access_token"]

# Use token
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/json",
    "X-Request-ID": str(uuid.uuid4())
}
```

## Request Signing (JWS)

For signed requests to the PSD2 API:

```
Digest: SHA-256={base64(sha256(body_bytes))}
x-jws-signature: {base64url(header.payload.signature)}
```

## Registration

1. Go to `https://api.bog.ge` and register as a developer
2. Alternatively, register at `bonline.bog.ge` for merchant services
3. Receive `client_id` and `secret_key`/`client_secret`
4. Configure redirect URIs and callback URLs
