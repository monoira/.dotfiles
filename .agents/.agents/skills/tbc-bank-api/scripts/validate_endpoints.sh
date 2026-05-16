#!/bin/bash
# TBC Bank API Endpoint Validator
# Checks reachability of TBC Bank API endpoints (no auth required)
# Usage: ./validate_endpoints.sh [--verbose]

set -euo pipefail

VERBOSE="${1:-}"
PASS=0
FAIL=0
WARN=0
RESULTS=()

check_endpoint() {
  local name="$1"
  local url="$2"
  local expected_code="${3:-200}"
  local method="${4:-GET}"

  local http_code
  http_code=$(curl -s -o /dev/null -w "%{http_code}" \
    -X "$method" \
    --connect-timeout 10 \
    --max-time 15 \
    -H "Content-Type: application/json" \
    "$url" 2>/dev/null || echo "000")

  if [[ "$http_code" == "000" ]]; then
    RESULTS+=("FAIL  $name  ($url) — Connection failed/timeout")
    ((FAIL++))
  elif [[ "$http_code" == "$expected_code" ]] || [[ "$http_code" =~ ^(200|301|302|401|403|405)$ ]]; then
    if [[ "$http_code" == "$expected_code" ]]; then
      RESULTS+=("PASS  $name  ($url) — HTTP $http_code")
      ((PASS++))
    else
      RESULTS+=("WARN  $name  ($url) — HTTP $http_code (expected $expected_code)")
      ((WARN++))
    fi
  else
    RESULTS+=("FAIL  $name  ($url) — HTTP $http_code (expected $expected_code)")
    ((FAIL++))
  fi
}

echo "═══════════════════════════════════════════════════════"
echo "  TBC Bank API Endpoint Validator"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════════════════"
echo ""

# --- Checkout / TPay ---
echo "▸ Checking Checkout / TPay API..."
check_endpoint "TBC API Base"              "https://api.tbcbank.ge"                              200
check_endpoint "Sandbox API Base"          "https://test-api.tbcbank.ge"                         200
check_endpoint "TPay Access Token"         "https://api.tbcbank.ge/v1/tpay/access-token"         401 POST
check_endpoint "TPay Payments"             "https://api.tbcbank.ge/v1/tpay/payments"             401 POST

# --- Exchange Rates ---
echo "▸ Checking Exchange Rates API..."
check_endpoint "Commercial Rates"          "https://api.tbcbank.ge/v1/exchange-rates/commercial" 401
check_endpoint "NBG Rates"                 "https://api.tbcbank.ge/v1/exchange-rates/nbg"        401

# --- Installments ---
echo "▸ Checking Installment API..."
check_endpoint "Installment Applications"  "https://api.tbcbank.ge/v1/online-installments/applications" 401 POST

# --- Open Banking ---
echo "▸ Checking Open Banking / PSD2..."
check_endpoint "OpenID Configuration"      "https://api.tbcbank.ge/.well-known/openid-configuration"   200
check_endpoint "Dev OpenBanking"           "https://dev-openbanking.tbcbank.ge"                  200
check_endpoint "Prod OpenBanking"          "https://openbanking.tbcbank.ge"                      200
check_endpoint "OAuth Authorize"           "https://api.tbcbank.ge/psd2/openbanking/oauth/authorize" 200
check_endpoint "JWKS Keys"                 "https://api.tbcbank.ge/.well-known/keys"             200

# --- Merchant Dashboard ---
echo "▸ Checking Merchant Portals..."
check_endpoint "Merchant Dashboard"        "https://ecom.tbcpayments.ge"                         200
check_endpoint "Developer Portal"          "https://developers.tbcbank.ge"                       200

# --- QR Payments ---
echo "▸ Checking QR Payments (v2)..."
check_endpoint "QR Payment Create"         "https://api.tbcbank.ge/v2/tpay/qr"                  401 POST

# --- Mortgage ---
echo "▸ Checking Mortgage API..."
check_endpoint "Mortgage Leads"            "https://api.tbcbank.ge/v1/online-mortgages/leads"    401 POST

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Results"
echo "═══════════════════════════════════════════════════════"

for result in "${RESULTS[@]}"; do
  case "$result" in
    PASS*) echo -e "  ✅ ${result#PASS  }" ;;
    WARN*) echo -e "  ⚠️  ${result#WARN  }" ;;
    FAIL*) echo -e "  ❌ ${result#FAIL  }" ;;
  esac
done

echo ""
echo "───────────────────────────────────────────────────────"
echo "  Summary: ✅ $PASS passed | ⚠️  $WARN warnings | ❌ $FAIL failed"
echo "───────────────────────────────────────────────────────"

if [[ "$VERBOSE" == "--verbose" ]]; then
  echo ""
  echo "Note: 401/403 = endpoint exists but requires authentication (expected)"
  echo "      301/302 = redirect (endpoint exists)"
  echo "      000     = connection failed or DNS resolution error"
fi

[[ $FAIL -eq 0 ]] && exit 0 || exit 1
