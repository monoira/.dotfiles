# TBC Bank — XML Billing Protocol (CHECK / PAY)

This protocol is used when TBC acts as the **payment aggregator** and sends requests **to the merchant's server**. Typical use case: utility/service bill payments where customers pay through TBC terminals, mobile banking, or internet banking.

This is the **reverse** of the Checkout/TPay flow — here TBC calls **your** endpoint, not the other way around.

---

## How It Works

Communication uses **HTTP(s)** with **GET/POST/SOAP** methods. Security options: VPN tunnel, SSL/TLS, IP filtering, authorization forms, field hashing.

The protocol operates in **two stages**:

| Stage | Purpose | Description |
|-------|---------|-------------|
| **CHECK** | Validate account | Verify the customer account exists and return customer info / debt |
| **PAY** | Process payment | Record the actual payment to the customer's account |

> **Note:** The protocol below is a **sample template**. You can design your own protocol and provide it to TBC — integration will follow your specification. Contact TBC to coordinate.

---

## Stage 1: CHECK (Account Verification)

TBC sends a request to your server to verify the customer exists.

### Request

```
GET/POST http(s)://yoursite.com/billing/?command=check&account={account}
```

| Parameter | Description |
|-----------|-------------|
| `command` | Always `check` |
| `account` | Customer identifier — can be ID, account number, username, etc. |

### Success Response (Account Found)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
  <result>0</result>
  <info>
    <extra name="Full Name">John Doe</extra>
    <extra name="Address">123 Rustaveli Ave, Tbilisi</extra>
    <extra name="Debt">150.00</extra>
  </info>
  <comment>OK</comment>
</response>
```

The `<info>` block can contain any number of `<extra>` fields relevant to your service — name, address, debt, balance, plan, etc.

### Error Response (Account Not Found)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
  <result>5</result>
  <comment>The Account Doesn't Exist</comment>
</response>
```

---

## Stage 2: PAY (Payment Processing)

After a successful CHECK, TBC sends the payment request.

### Request

```
GET/POST http(s)://yoursite.com/billing/?command=pay&txn_id={txn_id}&account={account}&sum={sum}
```

| Parameter | Description |
|-----------|-------------|
| `command` | Always `pay` |
| `txn_id` | Unique transaction ID from TBC (use for deduplication) |
| `account` | Customer identifier (same as CHECK) |
| `sum` | Payment amount in GEL (decimal, e.g., `10.50`) |

### Success Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
  <result>0</result>
  <comment>OK</comment>
</response>
```

### Error Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<response>
  <result>1</result>
  <comment>Temporary Database Error. Try Again Later</comment>
</response>
```

---

## Result Codes

| Code | Meaning | TBC Behavior |
|------|---------|--------------|
| `0` | Success | Operation completed |
| `1` | Server timeout / temporary error | TBC will **retry** the same transaction |
| `4` | Invalid account format | Rejected — no retry |
| `5` | Customer does not exist | Rejected — no retry |
| `7` | Payment acceptance prohibited | Rejected — no retry |
| `215` | Duplicate transaction (same `txn_id` already succeeded) | Treated as already completed |
| `275` | Invalid amount | Rejected — no retry |
| `300` | Unknown fatal error | TBC will **retry** the same transaction |

**Important behaviors:**
- Code `1` and `300` trigger automatic retries with the **same `txn_id`**
- Code `215` means you already processed this `txn_id` — return it instead of processing again
- Always check `txn_id` for deduplication before applying payment

---

## Implementation Checklist

```
□ Expose HTTPS endpoint at agreed URL
□ Accept both GET and POST methods
□ Parse command parameter to route CHECK vs PAY
□ CHECK: validate account, return customer info + debt
□ PAY: validate account, check txn_id dedup, apply payment, return result
□ Handle txn_id deduplication (return 215 for already-processed transactions)
□ Return proper XML with UTF-8 encoding
□ Log all requests with txn_id for reconciliation
□ Coordinate with TBC on security method (VPN, SSL, IP filtering, hashing)
□ Test both CHECK and PAY flows with TBC integration team
```

---

## Example Implementation (Python/Flask)

```python
from flask import Flask, request, Response
import xml.etree.ElementTree as ET

app = Flask(__name__)

def xml_response(result_code, comment, info=None):
    root = ET.Element("response")
    ET.SubElement(root, "result").text = str(result_code)
    if info:
        info_el = ET.SubElement(root, "info")
        for name, value in info.items():
            extra = ET.SubElement(info_el, "extra", name=name)
            extra.text = str(value)
    ET.SubElement(root, "comment").text = comment
    xml_str = '<?xml version="1.0" encoding="UTF-8"?>\n' + ET.tostring(root, encoding="unicode")
    return Response(xml_str, mimetype="application/xml")

@app.route("/billing/", methods=["GET", "POST"])
def billing():
    command = request.args.get("command") or request.form.get("command")
    account = request.args.get("account") or request.form.get("account")

    if command == "check":
        customer = lookup_customer(account)
        if not customer:
            return xml_response(5, "The Account Doesn't Exist")
        return xml_response(0, "OK", info={
            "Full Name": customer["name"],
            "Debt": str(customer["debt"]),
        })

    elif command == "pay":
        txn_id = request.args.get("txn_id") or request.form.get("txn_id")
        amount = request.args.get("sum") or request.form.get("sum")

        if is_duplicate_txn(txn_id):
            return xml_response(215, "Duplicate transaction")

        customer = lookup_customer(account)
        if not customer:
            return xml_response(5, "The Account Doesn't Exist")

        success = apply_payment(account, txn_id, float(amount))
        if success:
            return xml_response(0, "OK")
        return xml_response(1, "Temporary Database Error. Try Again Later")

    return xml_response(300, "Unknown command")
```

---

## Security Options

Discuss with TBC which combination to use:

| Method | Description |
|--------|-------------|
| **VPN** | Dedicated VPN tunnel between TBC and your server |
| **SSL/TLS** | HTTPS with valid certificate |
| **IP Filtering** | Whitelist TBC's sending IP addresses |
| **Authorization** | HTTP Basic Auth or custom auth header |
| **Field Hashing** | HMAC/hash of request fields for integrity verification |
