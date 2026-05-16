---
name: bank-of-georgia-api
description: >
  Expert guide for integrating Bank of Georgia (BOG) APIs — Open Banking PSD2, iPay payment gateway,
  installment loans, BOG SDK (BOG.Calculator, BOG.SmartButton), OAuth2, BOG-ID (SSO), Business Online
  (BOnline) corporate banking, Payment Gateway (billing/service providers), and banking products.
  Covers both bank-side API usage AND merchant-side implementation: webhook/callback handlers, redirect URLs,
  idempotency, environment setup, registration documents, and go-live checklist.
  Also generates merchant integration documents (technical specs, go-live checklists, service provider specs,
  SDK integration details) in markdown format — use when the user needs to prepare documentation that BOG
  requires from merchants.
  Use this skill whenever the user mentions Bank of Georgia, BOG, bog.ge, api.bog.ge, iPay, BOG installments,
  BOG SDK, BOG-ID, BOnline, Georgian bank integration, callback handling, merchant registration,
  merchant documentation, integration docs, go-live checklist, or any BOG-related development.
  Trigger even if they just say "BOG" in a tech/banking context.
---

# Bank of Georgia API Integration Guide

End-to-end reference for integrating BOG payment services — covering both the bank's APIs and everything the **merchant must build and register**.

## Quick Reference

| Topic | Reference File |
|-------|---------------|
| OAuth2 & Authentication | `references/auth.md` |
| Open Banking / PSD2 (AIS + PIS) | `references/openbanking.md` |
| iPay Payment Gateway | `references/ipay.md` |
| Installment Loans + BOG SDK | `references/installments.md` |
| Banking Products & Statements | `references/products.md` |
| BOG-ID (Single Sign-On) | `references/bogid.md` |
| Business Online (BOnline) | `references/bonline.md` |
| Payment Gateway (Billing) | `references/payment-gateway.md` |
| **Merchant Integration Guide** | **`references/merchant-integration.md`** |
| **Merchant Registration & Documents** | **`references/merchant-documents.md`** |
| **Merchant Doc Generator** | **`references/merchant-doc-generator.md`** |
| **Postman Collection Generator** | **`references/postman-collection.md`** |

## Base URLs

| Environment | Base URL |
|-------------|----------|
| PSD2 Sandbox | `https://xs2a-sandbox.bog.ge/0.8/` |
| iPay Sandbox | `https://ipay.ge` (test mode via credentials) |
| Installment | `https://installment.bog.ge/v1/` |
| Production API | `https://api.bog.ge` |
| WebStatic (SDK) | `https://webstatic.bog.ge` |

## Universal Headers

```http
Authorization: Bearer {jwt_token}
Content-Type: application/json
X-Request-ID: {uuid4}
PSU-IP-Address: {user_ip}
```

For some endpoints use Basic auth:
```http
Authorization: Basic {base64(client_id:client_secret)}
```

For signed requests:
```http
Digest: SHA-256={base64_body_hash}
x-jws-signature: {jws_signature}
```

## Common Error Response

```json
{
  "type": "https://...",
  "title": "Error summary",
  "status": 400,
  "detail": "Detailed description",
  "instance": "/path/to/resource",
  "code": "APP_ERROR_CODE",
  "traceId": "abc123"
}
```

## Key Workflows

### 1. Account/Transaction Data Access (AIS)
1. Create consent
2. User authorizes via SCA redirect or OAuth
3. Use `Consent-ID` header on AIS requests

→ Read `references/openbanking.md`

### 2. Payment Initiation (PIS)
1. POST payment → get `paymentId` + `_links`
2. Redirect or OAuth SCA authorization
3. Poll status or receive callback

→ Read `references/openbanking.md`

### 3. E-commerce Payments (iPay)
For simple card payments, pre-auth, and refunds.

→ Read `references/ipay.md`

### 4. Installment Loans
Two options:
- **API only** — backend integration
- **SDK** — `BOG.Calculator` frontend modal

→ Read `references/installments.md`

### 5. Authentication
→ Read `references/auth.md` first

### 5a. BOG-ID (Single Sign-On)
Authenticate users with their BOG credentials. Supports scopes for personal info, documents, contacts.

→ Read `references/bogid.md`

### 5b. Business Online (Corporate Banking)
Domestic/foreign transfers, statements, exchange rates, document signing with OTP.

→ Read `references/bonline.md`

### 5c. Payment Gateway (Billing/Service Providers)
For utility/telecom service providers accepting payments via BOG interfaces. Supports Basic, OAuth2, API Key, HMAC-SHA256 auth.

→ Read `references/payment-gateway.md`

### 6. Merchant Integration (What YOU Must Build)
1. Set up webhook/callback endpoints (HTTPS, idempotent, returns 200)
2. Validate `shop_order_id` and `amount` before fulfilling
3. Set up OAuth2 redirect handler (state param, code exchange)
4. Configure environment variables (credentials + URLs)
5. Handle duplicate webhook delivery (idempotency by `order_id` + `event`)

→ Read `references/merchant-integration.md`

### 7. Bank Registration & Go-Live Documents
1. Register at `https://bonline.bog.ge` (iPay/installments) or `https://api.bog.ge` (PSD2)
2. Prepare technical specification with your URLs
3. Gather required business documents
4. Submit go-live request after sandbox testing

→ Read `references/merchant-documents.md`

### 8. Generate Merchant Documentation
When the user needs to prepare documents that BOG requires — technical specs, go-live checklists, service provider specs, or SDK integration details — generate markdown docs using the templates.

1. Ask which integration type(s) they're using
2. Gather their company info, URLs, and tech stack
3. Generate the appropriate markdown document from templates
4. Save to their project directory (e.g., `docs/bog-integration-spec.md`)

Available templates:
- **Integration Technical Specification** — full technical spec for BOG submission
- **Payment Gateway / Service Provider Specification** — for billing/utility providers
- **Go-Live Readiness Checklist** — pre-launch document with business docs + technical readiness
- **SDK Integration Details** — for BOG.Calculator / SmartButton implementations

→ Read `references/merchant-doc-generator.md`

## Scripts

### Validate Endpoints
Check that all BOG API endpoints are reachable:
```bash
bash scripts/validate_endpoints.sh           # Run validation
bash scripts/validate_endpoints.sh --verbose  # With explanations
```

### Scrape Latest Documentation
Fetch latest docs from BOG developer portals and compare against current references:
```bash
python scripts/scrape_docs.py                          # Show diff summary
python scripts/scrape_docs.py --output /tmp/bog-docs   # Save scraped content
python scripts/scrape_docs.py --firecrawl              # Use Firecrawl for JS pages (set FIRECRAWL_API_KEY)
python scripts/scrape_docs.py --json                   # JSON output
```

### When to Run Scrape Scripts

Run `scrape_docs.py` in these situations — this keeps your reference files accurate and prevents implementing against stale API contracts:

1. **Before starting any new BOG integration** — ensures you're coding against the latest API spec, not outdated references
2. **When you encounter unexpected API errors** (401, 404, changed response shapes) — BOG may have updated endpoints, auth flows, or SDK versions
3. **When the user says "check for updates"** or mentions BOG recently changed something
4. **Periodically during active development** — run at least once per sprint or weekly during integration work
5. **Before generating merchant documentation** — so generated docs reflect the current API state
6. **After BOG SDK version changes** — the SDK script URL includes a version parameter that may change

After scraping, review the diff summary. If changes are found, update the relevant `references/*.md` files before proceeding with implementation.

Run `validate_endpoints.sh` before any go-live checklist or when switching between sandbox and production environments.

## Naming Conventions (Skill-Specific)

Every artifact created using this skill MUST use BOG-specific naming to avoid collisions with other bank integrations (e.g., TBC). This matters because Georgian merchants frequently integrate both TBC and BOG simultaneously.

### File Naming

| Artifact Type | Naming Pattern | Example |
|---------------|---------------|---------|
| Webhook/callback handler | `bog-*.{ext}` | `bog-ipay-webhook.ts`, `bog-callback-handler.py` |
| Service/module | `bog-*.{ext}` | `bog-ipay-service.ts`, `bog-auth.py` |
| Config/env keys | `BOG_*` | `BOG_CLIENT_ID`, `BOG_SECRET_KEY`, `BOG_WEBHOOK_URL` |
| Route prefix | `/bog/*` or `/webhooks/bog/*` | `/webhooks/bog/ipay`, `/api/bog/installments` |
| Documentation | `bog-*.md` | `bog-integration-spec.md`, `bog-go-live-checklist.md` |
| Postman collection | `bog-*.postman_collection.json` | `bog-ipay-api.postman_collection.json` |
| Test files | `bog-*.test.{ext}` | `bog-ipay.test.ts`, `test_bog_payment.py` |
| Docker/compose | `bog-*` | `bog-payment-service` (container name) |
| Database tables/columns | `bog_*` | `bog_order_id`, `bog_transaction_log` |

### Code Naming

```
// Classes/modules: prefix with Bog
class BogIpayService { ... }
class BogInstallmentHandler { ... }

// Functions: prefix with bog
function bogCreateOrder() { ... }
function bogVerifyWebhook() { ... }

// Constants
const BOG_SANDBOX_URL = "https://ipay.ge"
const BOG_PRODUCTION_URL = "https://api.bog.ge"
const BOG_SDK_URL = "https://webstatic.bog.ge/bog-sdk/bog-sdk.js"
```

### Why This Matters
When a project integrates both TBC and BOG, generic names like `payment-webhook.ts` or `CLIENT_SECRET` become ambiguous. BOG-specific prefixes make the codebase navigable and prevent subtle bugs from routing payments to the wrong handler.

## Postman Collection Generation

When creating documentation or implementing an integration, ALSO generate a Postman collection for the **merchant's own endpoints** — the webhook handlers, callback receivers, service provider endpoints, and auth redirect handlers the merchant builds on their server. No bank-side URLs (bog.ge, ipay.ge) in these collections.

→ Read `references/postman-collection.md` for collection templates and generation instructions

### Quick Postman Generation

For each integration type, generate a `bog-{type}-merchant.postman_collection.json` with:
- Pre-configured environments (local dev + staging)
- All merchant-side endpoints with simulated BOG request bodies
- Test scripts that validate response codes, timeouts, and idempotency
- Variables for `{{merchant_base_url}}`, `{{bog_order_id}}`, `{{bog_transaction_id}}`

Save Postman files to the user's project directory (e.g., `docs/postman/bog-ipay-merchant.postman_collection.json`).

## Response Conventions

- Monetary amounts are **strings** (`"amount": "100.50"`)
- Dates use **ISO 8601** format
- HATEOAS `_links` pattern throughout — follow links, don't hardcode paths
- `transactionStatus`: `RCVD`, `ACTC`, `ACCP`, `ACFC`, `ACSP`, `ACCC`, `RJCT`
- `scaStatus`: `received`, `psuIdentified`, `psuAuthenticated`, `scaMethodSelected`, `finalised`, `failed`
