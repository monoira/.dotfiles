# Bank of Georgia — Merchant Documentation Generator

This reference helps merchants generate the documents Bank of Georgia requires during integration and go-live review. When the user wants to create integration docs, technical specs, or go-live documents for BOG, use the templates below.

---

## How to Use

1. Ask the user which integration type(s) they need docs for
2. Gather their specific values (URLs, company info, tech stack)
3. Generate the markdown document using the appropriate template
4. Save to their project (e.g., `docs/bog-integration-spec.md`)

---

## Template 1: Integration Technical Specification

Generate this when the merchant needs to submit technical details to BOG.

```markdown
# Bank of Georgia — Integration Technical Specification

**Company:** [Company Name]
**TIN / Identification Code:** [Tax ID]
**Date:** [YYYY-MM-DD]
**Prepared by:** [Name, Role]

## Integration Type

- [ ] iPay (e-commerce card payments)
- [ ] Installment Loans (Direct API)
- [ ] Installment Loans (BOG SDK — Calculator / SmartButton)
- [ ] Open Banking / PSD2 (AIS / PIS)
- [ ] BOG-ID (Single Sign-On)
- [ ] Business Online (BOnline) corporate banking
- [ ] Payment Gateway (billing / service provider)

## Company Information

| Field | Value |
|-------|-------|
| Legal Entity Name | |
| Trading Name | |
| Registration Number | |
| Website | |
| Business Description | |
| Settlement Bank Account (IBAN) | |

## Technical Contact

| Field | Value |
|-------|-------|
| Name | |
| Email | |
| Phone | |

## Environment URLs

### iPay (Card Payments)

| URL Type | Value |
|----------|-------|
| Webhook URL | https://yourshop.com/webhooks/bog-ipay |
| Success Redirect | https://yourshop.com/payment/success |
| Fail Redirect | https://yourshop.com/payment/failed |
| Cancel Redirect | https://yourshop.com/payment/cancel |

### Installment Loans

| URL Type | Value |
|----------|-------|
| Callback URL | https://yourshop.com/installments/bog-callback |
| Success Redirect | https://yourshop.com/order/success |
| Fail Redirect | https://yourshop.com/order/failed |

### BOG-ID / OAuth2

| URL Type | Value |
|----------|-------|
| OAuth2 Redirect URI | https://yourshop.com/oauth/bog/callback |

### Open Banking / PSD2

| URL Type | Value |
|----------|-------|
| OAuth2 Redirect URI | https://yourshop.com/oauth/bog-psd2/callback |
| Required Scopes | openid, accounts, payments |
| Server IPs | |

### Payment Gateway (Billing / Service Provider)

| URL Type | Value |
|----------|-------|
| Payment Endpoint | https://yourservice.com/api/bog-payment |
| Status Check Endpoint | https://yourservice.com/api/bog-status |
| Auth Method | Basic / OAuth2 / API Key / HMAC-SHA256 |

## Technology Stack

| Layer | Technology |
|-------|-----------|
| Backend | |
| Frontend | |
| Database | |
| Hosting / Cloud | |
| Server IP(s) | |

## Business Details

| Field | Value |
|-------|-------|
| Monthly Transaction Volume (est.) | |
| Average Transaction Amount | |
| Product/Service Categories | |
| Recurring Payments Needed | Yes / No |
| Pre-Authorization (Hold & Capture) | Yes / No |
| Installment Min Price | ≥300 GEL |
| Supported Currencies | GEL / USD / EUR |
| Expected Go-Live Date | |

## Sandbox Testing Completed

- [ ] OAuth2 token generation tested
- [ ] iPay order creation and checkout redirect tested
- [ ] Webhook endpoint receives and processes notifications
- [ ] Order status fetch after webhook works correctly
- [ ] Shop order status updated based on payment status
- [ ] Amount validation: callback amount matches stored order
- [ ] Refund flow tested
- [ ] Idempotency: duplicate webhooks handled (order_id + event)
- [ ] Error scenarios handled (timeouts, invalid data)
- [ ] Success/fail/cancel redirects work correctly
- [ ] State parameter verified in OAuth2 flow
- [ ] Installment flow tested (if applicable)
- [ ] BOG SDK integration tested (if using Calculator/SmartButton)
- [ ] Payment Gateway CHECK/PAY tested (if service provider)
- [ ] Pre-authorization hold & capture tested (if applicable)

## Required Website Pages

- [ ] Terms & Conditions page
- [ ] Return / Refund Policy page
- [ ] Privacy Policy page
- [ ] Delivery Policy page (if physical goods)
- [ ] Contact Information page
```

---

## Template 2: Payment Gateway / Service Provider Specification

Generate this when a billing/service provider needs to document their integration with BOG Payment Gateway.

```markdown
# BOG Payment Gateway — Service Provider Specification

**Service Provider:** [Company Name]
**Service Name:** [e.g., "Internet Service", "Utility Payments"]
**Date:** [YYYY-MM-DD]

## Endpoint Configuration

| Field | Value |
|-------|-------|
| Payment Endpoint | https://yourservice.com/api/bog-payment |
| Status Check Endpoint | https://yourservice.com/api/bog-status |
| Cancel Endpoint | https://yourservice.com/api/bog-cancel |
| Protocol | HTTPS |
| Content-Type | application/json |

## Authentication Method

| Method | Enabled | Details |
|--------|---------|---------|
| HTTP Basic Auth | Yes/No | client_id:secret_key |
| OAuth 2.0 | Yes/No | client_credentials grant |
| API Key | Yes/No | Auth-Key header |
| HMAC-SHA256 | Yes/No | Request body/query signing |

## Customer Identifier

| Field | Description |
|-------|-------------|
| Parameter Name | `personalNumber` / `accountId` / custom |
| Format | [e.g., 11-digit personal number] |
| Example | [e.g., 01234567890] |
| Additional Params | [e.g., birthDate, contractNumber] |

## Supported Operations

| Operation | Supported | Endpoint |
|-----------|-----------|----------|
| Payment | Yes/No | POST /api/bog-payment |
| Status Check | Yes/No | GET /api/bog-status?transactionId=X |
| Cancel | Yes/No | GET /api/bog-cancel?transactionId=X |

## Response Status Codes

| Code | Meaning |
|------|---------|
| 0 | OK |
| 1 | Access Denied |
| 2 | Invalid credentials |
| 3 | Invalid hash |
| 4 | Missing required parameter |
| 5 | Invalid parameter |
| 6 | Customer does not exist |
| 7 | Invalid amount |
| 8 | Non-unique transaction |
| 9 | Operation not possible |
| 12 | Successful |
| 13 | Failed |
| 14 | In progress |
| 99 | General error |

## Testing Contacts

| Role | Contact |
|------|---------|
| Technical Lead | [Name, email, phone] |
| Support / Escalation | [Name, email, phone] |
```

---

## Template 3: Go-Live Readiness Checklist

Generate this when merchant is preparing to go live with BOG.

```markdown
# Bank of Georgia — Go-Live Readiness Checklist

**Company:** [Company Name]
**Integration Type:** [iPay / Installments / PSD2 / BOG-ID / Payment Gateway / BOnline]
**Target Go-Live Date:** [YYYY-MM-DD]
**Prepared by:** [Name]

## Business Documents

### Georgian Legal Entity
- [ ] Extract from National Business Register (< 3 months old)
- [ ] Company charter / Articles of Association
- [ ] Director's Georgian ID card or passport copy
- [ ] Director authorization letter (if signatory differs from registered director)
- [ ] BOG business bank account number (for settlement)
- [ ] Tax registration certificate (TIN / identification code)
- [ ] Signed BOG merchant/service agreement
- [ ] PCI DSS certificate (if storing/processing/transmitting card data)

### Foreign Legal Entity
- [ ] Certificate of Incorporation (with apostille)
- [ ] Company charter (apostilled + notarized Georgian translation)
- [ ] Director's passport copy (notarized)
- [ ] Power of Attorney for Georgian representative (apostilled)
- [ ] International or Georgian bank account for settlement
- [ ] Signed merchant agreement

## Technical Readiness

### iPay
- [ ] OAuth2 token generation working in production
- [ ] Order creation and checkout redirect tested
- [ ] Webhook URL publicly accessible via HTTPS
- [ ] Webhook handler returns HTTP 200 within 10 seconds
- [ ] Idempotent webhook processing (order_id + event)
- [ ] Amount validation: verify callback amount vs stored order
- [ ] Refund flow tested
- [ ] Redirect URLs working (success, fail, cancel)
- [ ] X-Request-ID sent with every request

### Installment Loans
- [ ] Production client_id and secret_key obtained from bonline.bog.ge
- [ ] Callback URL handling order_payment, order_cancelled, order_reverse events
- [ ] SDK integration tested (if using BOG.Calculator / SmartButton)
- [ ] Backend /api/create-installment-order endpoint working

### Open Banking / PSD2
- [ ] eIDAS qualified certificate obtained
- [ ] mTLS connection tested in production
- [ ] OAuth2 authorization code flow working
- [ ] Consent creation and SCA redirect tested
- [ ] JWS request signing implemented

### BOG-ID
- [ ] OAuth2 redirect flow working
- [ ] Token exchange implemented
- [ ] User info retrieval working for required scopes
- [ ] State parameter CSRF protection verified

### Payment Gateway (Service Provider)
- [ ] Payment endpoint accessible and tested
- [ ] Status check endpoint working
- [ ] Authentication method agreed and configured
- [ ] All status codes implemented and documented

## Website Requirements
- [ ] Terms & Conditions page live
- [ ] Return / Refund Policy page live
- [ ] Privacy Policy page live
- [ ] Delivery Policy page live (if physical goods)
- [ ] Contact Information page live

## Environment Configuration
- [ ] All environment variables set for production
- [ ] API base URLs switched from sandbox to production
- [ ] Monitoring / alerting configured
- [ ] Error logging in place
- [ ] Secrets stored securely (env vars / secrets manager)

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Technical Lead | | | |
| Project Manager | | | |
| BOG Contact | | | |
```

---

## Template 4: SDK Integration Details

Generate this when merchant uses BOG.Calculator or BOG.SmartButton.

```markdown
# BOG SDK Integration Details

**Company:** [Company Name]
**Date:** [YYYY-MM-DD]

## SDK Configuration

| Field | Value |
|-------|-------|
| Client ID | [from bonline.bog.ge registration] |
| SDK Script URL | https://webstatic.bog.ge/bog-sdk/bog-sdk.js?version=2&client_id={CLIENT_ID} |
| Website URL | |
| Pages Using SDK | [e.g., product pages, cart page] |

## Backend API Endpoint

| Field | Value |
|-------|-------|
| Endpoint | POST /api/create-installment-order |
| Authentication | [Bearer token / session] |
| Request Body | amount, campaignId, products[], callbackUrl, redirectUrls |
| Response | order_id, redirect_url |

## Product Categories Using Installments

| Category | Min Price (GEL) | Max Price (GEL) |
|----------|----------------|-----------------|
| | | |

## Callback Handling

| Event | Action |
|-------|--------|
| order_payment | Mark order as paid |
| order_cancelled | Cancel/void order |
| order_reverse | Process refund |
```

---

## Postman Collection Output

Every documentation generation MUST also produce a corresponding Postman collection. This is not optional — developers need testable API surfaces alongside written docs.

### What to Generate

When generating docs for any integration type, also create:

1. **Postman collection** — `bog-{type}.postman_collection.json` with all endpoints for that integration
2. **Environment files** — `bog-sandbox.postman_environment.json` and `bog-production.postman_environment.json`

### File Output Structure

```
docs/
├── bog-integration-spec.md              # Markdown documentation
├── bog-go-live-checklist.md             # Go-live checklist
├── bog-sdk-integration.md               # SDK details (if applicable)
├── bog-payment-gateway-spec.md          # Service provider spec (if applicable)
└── postman/
    ├── bog-ipay-merchant.postman_collection.json
    ├── bog-installments-merchant.postman_collection.json
    ├── bog-payment-gateway-merchant.postman_collection.json
    ├── bog-oauth-merchant.postman_collection.json
    ├── bog-merchant-local.postman_environment.json
    └── bog-merchant-staging.postman_environment.json
```

Postman collections test the **merchant's own endpoints** (webhooks, callbacks, service provider handlers, redirect pages) — not BOG's bank-side APIs.

→ See `references/postman-collection.md` for the full Postman collection templates and structure

### Naming Rule

All generated files use the `bog-` prefix. Never use generic names like `api-collection.json` or `integration-spec.md` — these collide when merchants integrate multiple banks.

---

## Usage Notes

- All documentation templates output **markdown (.md)** format
- All API collections output **Postman v2.1 JSON** format
- Customize templates based on which integration types the merchant uses — remove irrelevant sections
- The user fills in their specific values; the skill generates the structure
- Documents can be exported to PDF if needed using any markdown-to-PDF tool
- Postman collections can be imported directly into Postman or used with Newman CLI for automated testing
- Templates are designed to match what BOG's integration team expects to receive
- Cross-reference with `references/merchant-documents.md` for the full list of required business documents
