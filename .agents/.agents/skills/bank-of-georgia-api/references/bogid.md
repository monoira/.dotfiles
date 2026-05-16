# BOG-ID (Single Sign-On)

BOG-ID enables users to authenticate with their Bank of Georgia credentials on your platform.

## Scopes

| Scope | Data |
|-------|------|
| `openid` | Required base scope |
| `FPI` | Full personal info (name, sex, citizenship, address, photo, phone, email) |
| `DI` | Document info (ID type, number, issue/expiry dates, issuer) |
| `BPI` | Basic personal info (firstName, lastName, birthDate, pin) |
| `PI` | Personal info (name, birth date, pin, sex) |
| `BI` | Birth info (country, place) |
| `CI` | Contact info (phone, email) |
| `loginByPin` | Login via personal number |

## Authorization Request

```
GET https://account.bog.ge/auth/realms/bog-id/protocol/openid-connect/auth
  ?client_id={client_id}
  &response_type=code
  &scope=openid FPI DI
  &redirect_uri={your_callback_url}
  &login_with_mobile=true    // optional: enable QR/mBank login
  &ui_locales=ka             // ka or en
```

User authenticates at BOG → redirected back with `?code=AUTH_CODE`.

## Token Exchange

```http
POST https://oauth2.bog.ge/auth/realms/bog-id/protocol/openid-connect/token
Authorization: Basic {base64(client_id:client_secret)}
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&code={auth_code}
&redirect_uri={same_redirect_uri}
```

**Response:**
```json
{
  "access_token": "<JWT>",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "...",
  "scope": "openid profile email",
  "id_token": "..."
}
```

## Get User Info

```http
GET https://bogid.bog.ge/v1/customer-data
  ?channel={client_id}
  &operationId={unique_operation_id}
Authorization: Bearer {access_token}
Content-Type: application/json
```

**Response fields** (vary by granted scopes):

| Field | Scope Required |
|-------|---------------|
| `firstName`, `lastName`, `birthDate`, `pin` | BPI |
| `sex`, `citizenshipCountry`, `homeAddress`, `actualAddress`, `photo`, `phone`, `mail` | FPI |
| `type`, `docNo`, `issueDate`, `issuerCountry`, `issuer`, `expiryDate` | DI |
| `birthCountry`, `birthPlace` | BI |
| `phone`, `mail` | CI |

## Integration Example

```python
from flask import Flask, redirect, request, session
import requests, base64, uuid

app = Flask(__name__)

BOG_CLIENT_ID = "your_client_id"
BOG_CLIENT_SECRET = "your_client_secret"
REDIRECT_URI = "https://yourapp.com/auth/bog/callback"

@app.get("/auth/bog/login")
def bog_login():
    state = str(uuid.uuid4())
    session["bog_state"] = state
    return redirect(
        f"https://account.bog.ge/auth/realms/bog-id/protocol/openid-connect/auth"
        f"?client_id={BOG_CLIENT_ID}&response_type=code"
        f"&scope=openid FPI DI&redirect_uri={REDIRECT_URI}"
        f"&state={state}&ui_locales=ka"
    )

@app.get("/auth/bog/callback")
def bog_callback():
    if request.args["state"] != session.pop("bog_state", None):
        return "CSRF check failed", 403

    creds = base64.b64encode(f"{BOG_CLIENT_ID}:{BOG_CLIENT_SECRET}".encode()).decode()
    token = requests.post(
        "https://oauth2.bog.ge/auth/realms/bog-id/protocol/openid-connect/token",
        data={"grant_type": "authorization_code", "code": request.args["code"], "redirect_uri": REDIRECT_URI},
        headers={"Authorization": f"Basic {creds}", "Content-Type": "application/x-www-form-urlencoded"}
    ).json()

    user = requests.get(
        f"https://bogid.bog.ge/v1/customer-data?channel={BOG_CLIENT_ID}&operationId={uuid.uuid4()}",
        headers={"Authorization": f"Bearer {token['access_token']}"}
    ).json()

    # user now contains firstName, lastName, pin, etc.
    return f"Welcome {user.get('firstName', 'User')}"
```
