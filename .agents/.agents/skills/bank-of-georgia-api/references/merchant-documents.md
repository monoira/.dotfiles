# Bank of Georgia — Merchant Registration Documents

This guide covers what information and documents a merchant must prepare and submit to BOG before going live.

---

## 1. Developer Portal Registration

### Portal URLs

| Integration | Registration Portal |
|-------------|-------------------|
| iPay (card payments) | `https://ipay.ge` → Merchant registration |
| Installment Loans | `https://bonline.bog.ge` → API registration |
| Open Banking PSD2 | `https://api.bog.ge` → Developer registration |
| General Merchant Services | `https://bog.ge` → Business section |

### What to Register

| Field | Description | Example |
|-------|-------------|---------|
| Company Name | Legal entity name | "My Shop Ltd" |
| Business Description | What your business does | "Online electronics retailer" |
| Website URL | Your live website | `https://yourshop.com` |
| Technical Contact Email | Developer contact | `dev@yourshop.com` |
| Technical Contact Phone | Developer phone | `+995 555 123456` |

### Credentials You Will Receive

| Integration | Credentials |
|-------------|------------|
| iPay | `client_id`, `secret_key` |
| Installments | `client_id`, `secret_key` |
| Open Banking PSD2 | `client_id`, `client_secret` |
| BOG SDK | `client_id` (embedded in script URL) |

---

## 2. Technical Information to Provide

### For iPay (Card Payments)

```
✅ Merchant display name (shown on checkout page)
✅ Webhook URL: https://yourshop.com/webhooks/bog-ipay
✅ Success redirect URL: https://yourshop.com/payment/success
✅ Fail redirect URL: https://yourshop.com/payment/failed
✅ Cancel redirect URL: https://yourshop.com/payment/cancel
✅ Supported currencies: GEL (default), USD, EUR
✅ Capture method: AUTOMATIC (immediate) or MANUAL (pre-auth)
✅ Expected monthly transaction volume (GEL)
✅ Average transaction amount
✅ Recurring payments needed: Yes/No
```

### For Installment Loans (Direct API)

```
✅ Merchant business name
✅ Callback URL: https://yourshop.com/installments/bog-callback
✅ Success redirect URL: https://yourshop.com/order/success
✅ Fail redirect URL: https://yourshop.com/order/failed
✅ Product categories you sell
✅ Minimum product price for installment (typically ≥300 GEL)
✅ Maximum product price
✅ Expected monthly installment volume
```

### For PSD2 Open Banking (AIS/PIS)

```
✅ Redirect URI (OAuth2): https://yourshop.com/oauth/bog/callback
✅ Scopes needed: openid, accounts, payments (specify which)
✅ eIDAS certificate (for production; test cert for sandbox)
✅ TPP authorization number (if registered TPP)
✅ Server IP addresses (for whitelisting if required)
```

---

## 3. Bank Document Checklist

### For Georgian Legal Entities

```
□ Extract from National Business Register (not older than 3 months)
□ Company charter / Articles of Association
□ Director's Georgian ID card or passport copy
□ Director authorization letter (if signatory differs from registered director)
□ BOG business bank account number (for settlement)
□ Tax registration certificate (TIN / identification code)
□ Signed BOG merchant/service agreement
□ PCI DSS certificate (if storing, processing, or transmitting card data)
```

### For Foreign Legal Entities

```
□ Certificate of Incorporation (with apostille)
□ Company charter (apostilled + notarized translation to Georgian)
□ Director's passport copy (notarized)
□ Power of Attorney for Georgian representative (apostilled)
□ International or Georgian bank account for settlement
□ Signed merchant agreement
```

---

## 4. Integration Information Letter

Technical summary to provide to BOG integration team:

```markdown
## BOG Integration Technical Specification
**Merchant:** [Your Company Name]
**TIN / Company ID:** [Registration Number]
**Date:** [Date]
**Integration Type:** [iPay / Installments / PSD2 / All]

### Environment URLs

| URL | Value |
|-----|-------|
| iPay Webhook URL | https://yourshop.com/webhooks/bog-ipay |
| iPay Success URL | https://yourshop.com/payment/success |
| iPay Fail URL | https://yourshop.com/payment/failed |
| iPay Cancel URL | https://yourshop.com/payment/cancel |
| Installment Callback URL | https://yourshop.com/installments/bog-callback |
| Installment Success URL | https://yourshop.com/order/success |
| Installment Fail URL | https://yourshop.com/order/failed |
| OAuth2 Redirect URI | https://yourshop.com/oauth/bog/callback |

### Technical Contact

| Field | Value |
|-------|-------|
| Name | [Developer/Tech Lead] |
| Email | dev@yourshop.com |
| Phone | +995 xxx xxx xxx |

### Integration Stack

| Layer | Technology |
|-------|-----------|
| Backend | Node.js / Python / Java / ... |
| Frontend | React / Vue / ... |
| Server IP(s) | [Your server IPs for whitelisting] |

### Business Details

| Field | Value |
|-------|-------|
| Monthly Volume Estimate | ~X,XXX GEL / X transactions |
| Average Order Value | ~XXX GEL |
| Product Categories | Electronics / Clothing / ... |
| Recurring Payments | Yes / No |
| Installment Min Price | 300 GEL |

### Sandbox Testing Completed

- [ ] iPay checkout flow tested end-to-end
- [ ] Webhook handler implemented and verified
- [ ] Idempotency tested (duplicate events handled)
- [ ] Refund flow tested
- [ ] Installment flow tested (if applicable)
- [ ] SDK integration tested (if using BOG.Calculator)

### Go-Live Date

Target production launch: [Date]
```

---

## 5. SDK Integration Details (Installments)

If using `BOG.Calculator` or `BOG.SmartButton`, provide:

```
✅ Website URL where SDK will be embedded
✅ Product pages and categories using installments
✅ Backend API endpoint that SDK calls: POST /api/create-installment-order
```

Ensure your backend endpoint is documented as per `references/merchant-integration.md`.

---

## 6. PCI DSS Requirements

**iPay (hosted checkout):** BOG's iPay handles card data — you typically do **not** need PCI DSS SAQ A if you redirect to their hosted page and never handle card numbers.

**If using tokenization / saved cards:**
- PCI DSS SAQ A-EP or SAQ D may apply
- Consult BOG's compliance team
- Never log, store, or print full card numbers

---

## 7. Go-Live Process

1. **Register** at the appropriate portal (`bonline.bog.ge` or `api.bog.ge`)
2. **Receive sandbox credentials** after registration
3. **Build and test** full integration in sandbox
4. **Complete testing checklist** (see `merchant-integration.md`)
5. **Submit go-live request** with technical specification document above
6. **Provide signed merchant agreement** and business documents
7. **BOG reviews** integration and documents (typically 3–10 business days)
8. **Receive production credentials** after approval
9. **Update environment variables** from sandbox to production
10. **Run first live transaction** with small amount (test mode)
11. **Monitor** closely for first 48 hours

---

## 8. Support Contacts

| Channel | Details |
|---------|---------|
| iPay/Installments Support | `https://bonline.bog.ge` — contact support section |
| Open Banking / PSD2 | `https://api.bog.ge` — developer support |
| Business Banking | Visit any BOG branch or `https://bog.ge/business` |
| API Documentation | `https://api.bog.ge/docs` |
| BOG Developer Telegram | Ask BOG team for access to developer channel |
