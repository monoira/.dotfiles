# TBC Exchange Rates API

Provides commercial and NBG (National Bank of Georgia) exchange rates, plus currency conversion.

---

## Authentication

Uses **apikey header only** (no Bearer token required):

```http
apikey: {your-api-key}
```

---

## Endpoints

### Get Commercial Rates

```http
GET /v1/exchange-rates/commercial?currency=USD,EUR
apikey: {your-api-key}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `currency` | string | Comma-separated ISO 4217 codes (e.g., `USD`, `EUR`, `GBP`) |

**Response:**
```json
{
  "base": "GEL",
  "commercialRatesList": [
    {
      "currency": "USD",
      "buy": 2.6450,
      "sell": 2.6850
    },
    {
      "currency": "EUR",
      "buy": 2.8700,
      "sell": 2.9200
    }
  ]
}
```

---

### Convert at Commercial Rate

```http
GET /v1/exchange-rates/commercial/convert?amount=1000&from=USD&to=GEL
apikey: {your-api-key}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `amount` | number | Amount to convert |
| `from` | string | Source currency (ISO 4217) |
| `to` | string | Target currency (ISO 4217) |

**Response:**
```json
{
  "from": "USD",
  "to": "GEL",
  "amount": 1000,
  "value": 2685.00,
  "rate": 2.6850
}
```

---

### Get NBG Official Rates

```http
GET /v1/exchange-rates/nbg
apikey: {your-api-key}
```

Returns the official National Bank of Georgia rates for the day.

**Response:**
```json
{
  "base": "GEL",
  "date": "2025-03-15",
  "rates": [
    {
      "currency": "USD",
      "rate": 2.6700
    },
    {
      "currency": "EUR",
      "rate": 2.9000
    }
  ]
}
```

---

### Convert at NBG Rate

```http
GET /v1/exchange-rates/nbg/convert?amount=1000&from=USD&to=GEL
apikey: {your-api-key}
```

Same parameters and response shape as the commercial convert endpoint, but uses the official NBG rate.

---

## Go-Live

The Exchange Rates API goes live **automatically** after successful testing. No manual review is required — once your integration returns `200` responses in the test environment, you can switch to production.
