# TBC Error Handling

---

## REST API Error Structure

All REST API errors return a consistent JSON format:

```json
{
  "status": 400,
  "type": "https://developers.tbcbank.ge/docs/errors#bad-request",
  "title": "Bad Request",
  "detail": "The 'amount' field must be greater than zero",
  "systemCode": "INVALID_AMOUNT",
  "code": "BR001"
}
```

| Field | Type | Description |
|-------|------|-------------|
| `status` | integer | HTTP status code |
| `type` | string | URI reference to the error documentation |
| `title` | string | Short human-readable summary |
| `detail` | string | Specific explanation of what went wrong |
| `systemCode` | string | TBC internal error classification |
| `code` | string | Machine-readable error code for programmatic handling |

---

## HTTP Status Codes

### Client Errors (4xx)

| Status | Title | Common Causes |
|--------|-------|---------------|
| `400` | Bad Request | Missing required fields, invalid field values, malformed JSON |
| `401` | Unauthorized | Expired or missing access token, invalid apikey |
| `403` | Forbidden | Insufficient scopes, IP not whitelisted, account not enabled |
| `404` | Not Found | Invalid resource ID, merchant not registered |
| `405` | Method Not Allowed | Wrong HTTP method (e.g., GET instead of POST) |
| `409` | Conflict | Duplicate request, resource already in target state |
| `415` | Unsupported Media Type | Missing or wrong Content-Type header |
| `422` | Unprocessable Entity | Valid JSON but semantically invalid (e.g., negative amount) |
| `429` | Too Many Requests | Rate limit exceeded — retry after `Retry-After` header value |

### Server Errors (5xx)

| Status | Title | Common Causes |
|--------|-------|---------------|
| `500` | Internal Server Error | Unexpected TBC-side failure — retry with exponential backoff |
| `502` | Bad Gateway | Upstream service unavailable — transient, retry |
| `503` | Service Unavailable | Planned maintenance or overload — check `Retry-After` header |

---

## SOAP Fault Codes (DBI / Open Banking)

SOAP responses use `<faultcode>` and `<faultstring>` in the envelope:

| Fault Code | Description |
|------------|-------------|
| `GENERAL_ERROR` | Unspecified server-side error |
| `INCORRECT_INPUT_DATA` | Request XML has missing or invalid fields |
| `USER_IS_NOT_ACTIVE` | DBI user account is disabled or locked |
| `INSUFFICIENT_FUNDS` | Account balance too low for the operation |
| `ACCOUNT_NOT_FOUND` | Target account does not exist |
| `DUPLICATE_TRANSACTION` | Transaction with same reference already processed |
| `OPERATION_NOT_PERMITTED` | User lacks permission for this operation |
| `SESSION_EXPIRED` | Authentication session timed out — re-authenticate |

---

## Checkout / Payment Result Codes

Returned in the payment status response after a TBC Checkout (TPay) transaction:

| Result Code | Meaning |
|-------------|---------|
| `approved` | Payment completed successfully |
| `decline_general` | Generic decline — card issuer rejected |
| `decline_expired_card` | Card has expired |
| `decline_insufficient_funds` | Not enough balance on the card |
| `decline_invalid_card` | Card number is invalid or not recognized |
| `decline_limit_exceeded` | Transaction exceeds card or account limits |
| `decline_stolen_card` | Card reported as stolen |
| `decline_lost_card` | Card reported as lost |
| `decline_restricted_card` | Card is restricted from this transaction type |
| `decline_3ds_failed` | 3D Secure authentication failed |
| `decline_fraud_suspected` | Transaction flagged by fraud detection |
| `error_timeout` | Processing timed out — status unknown, verify manually |
| `error_system` | TBC system error during processing |
| `cancelled` | Customer cancelled the payment flow |

---

## Troubleshooting Quick Reference

| Symptom | Check |
|---------|-------|
| `401` on every request | Is your access token expired? Refresh it. Is `apikey` header present? |
| `404` on installments | Is your `merchantKey` correct? Have you been onboarded for installments? |
| `400` with no detail | Log the full response body — `systemCode` often has the real cause |
| `429` rate limited | Implement exponential backoff. Check `Retry-After` header for wait time |
| SOAP `GENERAL_ERROR` | Check XML structure against WSDL. Ensure namespace prefixes are correct |
| SOAP `USER_IS_NOT_ACTIVE` | Contact TBC to verify DBI credentials are active |
| Checkout `decline_3ds_failed` | Customer failed 3DS — prompt them to retry or use a different card |
| Checkout `error_timeout` | Do NOT retry the payment. Call GET status to check if it went through |
| Callback not arriving | Verify IP whitelist (193.104.20.44/45, 185.52.80.44/45) and that you return 200 |
