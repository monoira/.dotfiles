---
name: tbc-bank-api
description: >
  Expert guide for integrating TBC Bank's APIs — Checkout (TPay) e-commerce payments, XML billing protocol
  (CHECK/PAY for service providers), online installment loans, exchange rates, Open Banking PSD2 (AIS, PIS),
  TBC ID, QR payments, mortgage leads, and DBI integration service.
  Covers both bank-side API usage AND merchant-side implementation: callback/webhook handlers, redirect URLs,
  signature verification, environment setup, registration documents, and go-live checklist.
  Also generates merchant integration documents (technical specs, go-live checklists, billing protocol specs)
  in markdown format — use when the user needs to prepare documentation that TBC requires from merchants.
  Use this skill whenever the user mentions TBC Bank, tbcbank.ge, TBC API, TPay, TBC checkout,
  TBC installments, TBC exchange rates, TBC Open Banking, PSD2 with TBC, TBC ID, TBC billing,
  TBC XML protocol, CHECK/PAY protocol, service provider integration with TBC,
  callback handling, merchant registration with TBC, merchant documentation, integration docs,
  go-live checklist, or any TBC Bank developer API work.
  Trigger even if they just say "TBC" in a banking/payments context.
---

# TBC Bank API Integration Guide

End-to-end reference for integrating TBC Bank payment and banking services — covering both the bank's APIs and everything the **merchant must build and register**.

## Quick Reference

| Topic | Reference File |
|-------|---------------|
| Authentication & Certificates | `references/auth.md` |
| Checkout / TPay (E-Commerce) | `references/checkout.md` |
| XML Billing Protocol (CHECK/PAY) | `references/xml-billing-protocol.md` |
| Online Installment Loans | `references/installments.md` |
| Exchange Rates API | `references/exchange-rates.md` |
| Open Banking / PSD2 + DBI | `references/openbanking.md` |
| Error Handling & Codes | `references/errors.md` |
| Design & Branding Guidelines | `references/design.md` |
| **Merchant Integration Guide** | **`references/merchant-integration.md`** |
| **Merchant Doc Generator** | **`references/merchant-doc-generator.md`** |
| **Postman Collection Generator** | **`references/postman-collection.md`** |

## Base URLs

| Environment | URL |
|-------------|-----|
| Sandbox (Checkout) | `https://test-api.tbcbank.ge` |
| Production | `https://api.tbcbank.ge` |
| Dev OpenBanking | `https://dev-openbanking.tbcbank.ge` |
| OpenBanking | `https://openbanking.tbcbank.ge` |
| Merchant Dashboard | `https://ecom.tbcpayments.ge` |

## Universal Headers

```http
apikey: {your_api_key}
Authorization: Bearer {access_token}
Content-Type: application/json
```

## Common Error Response

```json
{
  "status": 400,
  "type": "https://api.tbcbank.ge/problems/bad-request",
  "title": "Bad Request",
  "detail": "Detailed description",
  "systemCode": "TBC-ERR-001",
  "code": "INVALID_REQUEST"
}
```

→ For full error reference, read `references/errors.md`

## Key Workflows

### 1. E-Commerce Payments (Checkout / TPay)
1. Get access token (`POST /v1/tpay/access-token`)
2. Create payment (`POST /v1/tpay/payments`) → get `payId` + `approval_url`
3. Redirect customer to `approval_url`
4. Receive callback POST with `PaymentId`
5. Get payment details (`GET /v1/tpay/payments/{payId}`)
6. Fulfill order if `status === "Succeeded"`

→ Read `references/checkout.md`

### 2. Pre-Authorization (Hold & Capture)
1. Create payment with `"preAuth": true`
2. Status becomes `WaitingConfirm` after authorization
3. Complete within 30 days: `POST /v1/tpay/payments/{payId}/completion`
4. Or cancel: `POST /v1/tpay/payments/{payId}/cancel`

→ Read `references/checkout.md`

### 3. Recurring Payments
1. First payment with `"saveCard": true` → get `recId`
2. Charge saved card: `POST /v1/tpay/payments/execution` with `recId`
3. Delete card: `POST /v1/tpay/payments/{recId}/delete`

→ Read `references/checkout.md`

### 4. XML Billing Protocol (Service Provider Payments)
For service/utility providers where TBC sends CHECK/PAY requests **to your server**. This is the reverse of TPay — here you expose an endpoint and TBC calls it.

1. Expose HTTPS endpoint (e.g., `/billing/`)
2. Handle `command=check` — validate account, return customer info + debt as XML
3. Handle `command=pay` — apply payment using `txn_id` for deduplication, return result XML
4. Result codes: `0` = success, `1`/`300` = retry, `5` = not found, `215` = duplicate
5. Security: agree with TBC on VPN, SSL, IP filtering, or field hashing

→ Read `references/xml-billing-protocol.md`

### 5. Online Installment Loans
1. Create application → get `sessionId` + redirect URL
2. Redirect customer to fill loan application
3. Poll status or confirm/cancel application
4. Monitor via merchant status changes endpoint

→ Read `references/installments.md`

### 6. Exchange Rates
- Commercial: `GET /v1/exchange-rates/commercial`
- Official (NBG): `GET /v1/exchange-rates/nbg`
- Convert: `GET /v1/exchange-rates/{type}/convert?amount=X&from=USD&to=GEL`

→ Read `references/exchange-rates.md`

### 7. Authentication
→ Read `references/auth.md` first — covers OAuth2, apikey, mTLS certificates, DBI auth

### 8. Open Banking / PSD2
Account movements, statements, payment initiation via PSD2 standard with mTLS.

→ Read `references/openbanking.md`

### 9. Design & Branding
TBC brand colors (`#00AEEF` primary blue), button variants, input styles, typography (`TBC Sailec Regular`), and card components for merchant payment UI.

→ Read `references/design.md`

### 10. Merchant Integration (What YOU Must Build)
1. Set up callback endpoint (HTTPS, returns 200, idempotent)
2. Whitelist TBC IPs: `193.104.20.44/45`, `185.52.80.44/45`
3. After receiving callback, GET payment details to verify status and amount
4. Configure environment variables (credentials + URLs)
5. Handle duplicate callback delivery (idempotency by PaymentId)

→ Read `references/merchant-integration.md`

### 11. Go-Live
- **Checkout:** Ensure website has Terms, Return Policy, Privacy Policy, Delivery Policy, Contact Info → activate via dashboard
- **Installments:** Email `merchant.support@tbcbank.ge` for production keys
- **Exchange Rates:** Automatic after testing
- **PSD2:** Certificate from authorized provider + TBC approval

→ Read `references/merchant-integration.md`

### 12. Generate Merchant Documentation
When the user needs to prepare documents that TBC requires — technical specs, go-live checklists, or billing protocol specifications — generate markdown docs using the templates.

1. Ask which integration type(s) they're using
2. Gather their company info, URLs, and tech stack
3. Generate the appropriate markdown document from templates
4. Save to their project directory (e.g., `docs/tbc-integration-spec.md`)

Available templates:
- **Integration Technical Specification** — full technical spec for TBC submission
- **XML Billing Protocol Specification** — for service providers using CHECK/PAY
- **Go-Live Readiness Checklist** — pre-launch document with business docs + technical readiness

→ Read `references/merchant-doc-generator.md`

## Scripts

### Validate Endpoints
Check that all TBC API endpoints are reachable:
```bash
bash scripts/validate_endpoints.sh           # Run validation
bash scripts/validate_endpoints.sh --verbose  # With explanations
```

### Scrape Latest Documentation
Fetch latest docs from developers.tbcbank.ge and compare against current references:
```bash
python scripts/scrape_docs.py                          # Show diff summary
python scripts/scrape_docs.py --output /tmp/tbc-docs   # Save scraped content
python scripts/scrape_docs.py --firecrawl              # Use Firecrawl for JS pages (set FIRECRAWL_API_KEY)
python scripts/scrape_docs.py --json                   # JSON output
```

### When to Run Scrape Scripts

Run `scrape_docs.py` in these situations — this keeps your reference files accurate and prevents implementing against stale API contracts:

1. **Before starting any new TBC integration** — ensures you're coding against the latest API spec, not outdated references
2. **When you encounter unexpected API errors** (401, 404, changed response shapes) — TBC may have updated endpoints or auth requirements
3. **When the user says "check for updates"** or mentions TBC recently changed something
4. **Periodically during active development** — run at least once per sprint or weekly during integration work
5. **Before generating merchant documentation** — so generated docs reflect the current API state

After scraping, review the diff summary. If changes are found, update the relevant `references/*.md` files before proceeding with implementation.

Run `validate_endpoints.sh` before any go-live checklist or when switching between sandbox and production environments.

## Naming Conventions (Skill-Specific)

Every artifact created using this skill MUST use TBC-specific naming to avoid collisions with other bank integrations (e.g., BOG). This matters because Georgian merchants frequently integrate both TBC and BOG simultaneously.

### File Naming

| Artifact Type | Naming Pattern | Example |
|---------------|---------------|---------|
| Webhook/callback handler | `tbc-*.{ext}` | `tbc-payment-callback.ts`, `tbc-webhook-handler.py` |
| Service/module | `tbc-*.{ext}` | `tbc-checkout-service.ts`, `tbc-auth.py` |
| Config/env keys | `TBC_*` | `TBC_CLIENT_ID`, `TBC_API_KEY`, `TBC_CALLBACK_URL` |
| Route prefix | `/tbc/*` or `/webhooks/tbc/*` | `/webhooks/tbc/checkout`, `/api/tbc/installments` |
| Documentation | `tbc-*.md` | `tbc-integration-spec.md`, `tbc-go-live-checklist.md` |
| Postman collection | `tbc-*.postman_collection.json` | `tbc-checkout-api.postman_collection.json` |
| Test files | `tbc-*.test.{ext}` | `tbc-checkout.test.ts`, `test_tbc_billing.py` |
| Docker/compose | `tbc-*` | `tbc-billing-service` (container name) |
| Database tables/columns | `tbc_*` | `tbc_payment_id`, `tbc_transaction_log` |

### Code Naming

```
// Classes/modules: prefix with Tbc
class TbcCheckoutService { ... }
class TbcBillingHandler { ... }

// Functions: prefix with tbc
function tbcCreatePayment() { ... }
function tbcVerifyCallback() { ... }

// Constants
const TBC_SANDBOX_URL = "https://test-api.tbcbank.ge"
const TBC_PRODUCTION_URL = "https://api.tbcbank.ge"
```

### Why This Matters
When a project integrates both TBC and BOG, generic names like `payment-callback.ts` or `MERCHANT_KEY` become ambiguous. TBC-specific prefixes make the codebase navigable and prevent subtle bugs from routing payments to the wrong handler.

## Postman Collection Generation

When creating documentation or implementing an integration, ALSO generate a Postman collection for the **merchant's own endpoints** — the webhook handlers, callback receivers, billing endpoints, and auth redirect handlers the merchant builds on their server. No bank-side URLs (tbcbank.ge) in these collections.

→ Read `references/postman-collection.md` for collection templates and generation instructions

### Quick Postman Generation

For each integration type, generate a `tbc-{type}-merchant.postman_collection.json` with:
- Pre-configured environments (local dev + staging)
- All merchant-side endpoints with simulated TBC request bodies
- Test scripts that validate response codes, timeouts, and idempotency
- Variables for `{{merchant_base_url}}`, `{{tbc_payment_id}}`, `{{tbc_txn_id}}`

Save Postman files to the user's project directory (e.g., `docs/postman/tbc-checkout-merchant.postman_collection.json`).

## Response Conventions

- Monetary amounts are **decimal numbers** (`"amount": 100.50`)
- Currency: `GEL`, `USD`, `EUR`
- Payment statuses: `Created`, `Processing`, `Succeeded`, `Failed`, `Expired`, `WaitingConfirm`, `Returned`, `PartialReturned`
- Callback body is minimal (`{"PaymentId":"..."}`) — always GET full details after receiving
