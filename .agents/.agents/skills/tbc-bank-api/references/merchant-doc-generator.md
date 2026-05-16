# TBC Bank — Merchant Documentation Generator

This reference helps merchants generate the documents TBC Bank requires during integration and go-live review. When the user wants to create integration docs, technical specs, or go-live documents for TBC, use the templates below.

---

## How to Use

1. Ask the user which integration type(s) they need docs for
2. Gather their specific values (URLs, company info, tech stack)
3. Generate the markdown document using the appropriate template
4. Save to their project (e.g., `docs/tbc-integration-spec.md`)

---

## Template 1: Integration Technical Specification

Generate this when the merchant needs to submit technical details to TBC.

```markdown
# TBC Bank — Integration Technical Specification

**Company:** [Company Name]
**TIN / Identification Code:** [Tax ID]
**Date:** [YYYY-MM-DD]
**Prepared by:** [Name, Role]

## Integration Type

- [ ] Checkout / TPay (e-commerce card payments)
- [ ] Online Installment Loans
- [ ] Exchange Rates API
- [ ] Open Banking / PSD2
- [ ] XML Billing Protocol (service provider payments)
- [ ] QR Payments

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

### Checkout / TPay

| URL Type | Value |
|----------|-------|
| Callback URL | https://yoursite.com/webhooks/tbc |
| Success Redirect | https://yoursite.com/payment/success |
| Fail Redirect | https://yoursite.com/payment/fail |

### Installment Loans

| URL Type | Value |
|----------|-------|
| Callback URL | https://yoursite.com/installments/tbc-callback |

### XML Billing Protocol

| URL Type | Value |
|----------|-------|
| Billing Endpoint | https://yoursite.com/billing/ |
| Supported Commands | CHECK, PAY |
| Security Method | SSL / VPN / IP Filter / Hashing |

### Open Banking / PSD2

| URL Type | Value |
|----------|-------|
| OAuth2 Redirect URI | https://yoursite.com/oauth/tbc/callback |
| Required Scopes | |
| Server IPs (for whitelisting) | |

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
| Pre-Authorization Needed | Yes / No |
| Installment Min Price | |
| Expected Go-Live Date | |

## Sandbox Testing Completed

- [ ] Access token generation tested
- [ ] Payment creation and redirect flow tested
- [ ] Callback endpoint receives and processes notifications
- [ ] Payment details fetch after callback works correctly
- [ ] Order status updated based on payment status
- [ ] Refund / cancellation flow tested
- [ ] IP whitelist configured (193.104.20.44/45, 185.52.80.44/45)
- [ ] Idempotency: duplicate callbacks handled correctly
- [ ] Error scenarios handled (timeouts, invalid data)
- [ ] Success/fail redirects work correctly
- [ ] Installment flow tested (if applicable)
- [ ] XML billing CHECK/PAY tested (if applicable)

## Required Website Pages (for Go-Live)

- [ ] Terms & Conditions page
- [ ] Return / Refund Policy page
- [ ] Privacy Policy page
- [ ] Delivery Policy page (if physical goods)
- [ ] Contact Information page
```

---

## Template 2: XML Billing Protocol Specification

Generate this when a service provider needs to document their billing endpoint for TBC.

```markdown
# TBC XML Billing Protocol — Service Provider Specification

**Service Provider:** [Company Name]
**Service Name:** [e.g., "Internet Service", "Utility Payments"]
**Date:** [YYYY-MM-DD]

## Endpoint

| Field | Value |
|-------|-------|
| URL | https://yoursite.com/billing/ |
| Protocol | HTTPS |
| Methods Supported | GET, POST |
| Encoding | UTF-8 |
| Response Format | XML |

## Security

| Method | Enabled | Details |
|--------|---------|---------|
| SSL/TLS | Yes/No | Certificate issuer: |
| VPN | Yes/No | |
| IP Filtering | Yes/No | Allowed IPs: |
| Auth Header | Yes/No | Scheme: |
| Field Hashing | Yes/No | Algorithm: |

## Account Identifier

| Field | Description |
|-------|-------------|
| Parameter Name | `account` |
| Format | [e.g., numeric, 6-10 digits] |
| Example | [e.g., 100234] |
| Description | [e.g., customer contract number] |

## CHECK Response Fields

| Extra Field Name | Description | Example |
|------------------|-------------|---------|
| Full Name | Customer full name | John Doe |
| Address | Service address | 123 Rustaveli Ave |
| Debt | Outstanding balance (GEL) | 45.50 |
| [Add more as needed] | | |

## PAY Behavior

| Scenario | Result Code | Comment |
|----------|-------------|---------|
| Success | 0 | OK |
| Temporary DB error | 1 | Retry later |
| Invalid account format | 4 | |
| Customer not found | 5 | |
| Payment blocked | 7 | |
| Duplicate txn_id | 215 | Already processed |
| Invalid amount | 275 | |
| Fatal error | 300 | Will be retried |

## Testing Contacts

| Role | Contact |
|------|---------|
| Technical Lead | [Name, email, phone] |
| Support / Escalation | [Name, email, phone] |
```

---

## Template 3: Go-Live Readiness Checklist

Generate this when merchant is preparing to go live with TBC.

```markdown
# TBC Bank — Go-Live Readiness Checklist

**Company:** [Company Name]
**Integration Type:** [Checkout / Installments / XML Billing / PSD2]
**Target Go-Live Date:** [YYYY-MM-DD]
**Prepared by:** [Name]

## Business Documents

### Georgian Legal Entity
- [ ] Extract from National Business Register (< 3 months old)
- [ ] Company charter / articles of association
- [ ] Director's Georgian ID card copy
- [ ] Director authorization letter (if signatory differs)
- [ ] TBC business bank account number (for settlement)
- [ ] Tax registration certificate
- [ ] Signed TBC merchant agreement

### Foreign Legal Entity
- [ ] Certificate of Incorporation (with apostille)
- [ ] Company charter (apostilled + notarized Georgian translation)
- [ ] Director's passport copy (notarized)
- [ ] Power of Attorney for Georgian representative (apostilled)
- [ ] Bank account for settlement
- [ ] Signed merchant agreement

## Technical Readiness

### Checkout / TPay
- [ ] Access token generation working in production
- [ ] Payment flow tested end-to-end
- [ ] Callback URL publicly accessible via HTTPS
- [ ] TBC IPs whitelisted (193.104.20.44/45, 185.52.80.44/45)
- [ ] Idempotent callback processing implemented
- [ ] Proper error handling for all result codes
- [ ] Redirect URLs working (success, fail)

### Installment Loans
- [ ] Production merchantKey and campaignId obtained
- [ ] Two test sessions submitted to developers@tbcbank.ge (COMPLETE + CANCELED)
- [ ] Status polling or callback handling implemented

### XML Billing Protocol
- [ ] HTTPS endpoint live and reachable by TBC
- [ ] CHECK command returns customer info correctly
- [ ] PAY command processes payments with txn_id dedup
- [ ] All result codes implemented
- [ ] Security method agreed with TBC (VPN/SSL/IP/hash)
- [ ] Tested with TBC integration team

### Open Banking / PSD2
- [ ] Qualified certificate obtained from authorized provider
- [ ] mTLS connection tested
- [ ] OAuth2 flow working in production
- [ ] Email sent to developers@tbcbank.ge for production access

## Website Requirements (Checkout)
- [ ] Terms & Conditions page live
- [ ] Return / Refund Policy page live
- [ ] Privacy Policy page live
- [ ] Delivery Policy page live
- [ ] Contact Information page live

## Environment Configuration
- [ ] All environment variables set for production
- [ ] API base URL switched from test to production
- [ ] Monitoring / alerting configured
- [ ] Error logging in place

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Technical Lead | | | |
| Project Manager | | | |
| TBC Contact | | | |
```

---

## Postman Collection Output

Every documentation generation MUST also produce a corresponding Postman collection. This is not optional — developers need testable API surfaces alongside written docs.

### What to Generate

When generating docs for any integration type, also create:

1. **Postman collection** — `tbc-{type}.postman_collection.json` with all endpoints for that integration
2. **Environment files** — `tbc-sandbox.postman_environment.json` and `tbc-production.postman_environment.json`

### File Output Structure

```
docs/
├── tbc-integration-spec.md              # Markdown documentation
├── tbc-go-live-checklist.md             # Go-live checklist
├── tbc-billing-protocol-spec.md         # XML billing spec (if applicable)
└── postman/
    ├── tbc-checkout-merchant.postman_collection.json
    ├── tbc-installments-merchant.postman_collection.json
    ├── tbc-billing-merchant.postman_collection.json
    ├── tbc-oauth-merchant.postman_collection.json
    ├── tbc-merchant-local.postman_environment.json
    └── tbc-merchant-staging.postman_environment.json
```

Postman collections test the **merchant's own endpoints** (webhooks, callbacks, billing handlers, redirect pages) — not TBC's bank-side APIs.

→ See `references/postman-collection.md` for the full Postman collection templates and structure

### Naming Rule

All generated files use the `tbc-` prefix. Never use generic names like `api-collection.json` or `integration-spec.md` — these collide when merchants integrate multiple banks.

---

## Usage Notes

- All documentation templates output **markdown (.md)** format
- All API collections output **Postman v2.1 JSON** format
- Customize templates based on which integration types the merchant uses — remove irrelevant sections
- The user fills in their specific values; the skill generates the structure
- Documents can be exported to PDF if needed using any markdown-to-PDF tool
- Postman collections can be imported directly into Postman or used with Newman CLI for automated testing
- Templates are designed to match what TBC's integration team expects to receive
