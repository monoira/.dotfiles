#!/bin/bash
# BOG API Endpoint Validator
# Checks reachability of Bank of Georgia API endpoints (no auth required)
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
    # 401/403 means endpoint exists but needs auth — that's valid
    # 301/302 means redirect — endpoint exists
    # 405 means method not allowed but endpoint exists
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
echo "  Bank of Georgia API Endpoint Validator"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════════════════"
echo ""

# --- iPay / Payments API ---
echo "▸ Checking iPay / Payments API..."
check_endpoint "iPay Base"               "https://ipay.ge"                                             200
check_endpoint "Payments API Base"       "https://api.bog.ge"                                          200
check_endpoint "OAuth2 Token Endpoint"   "https://oauth2.bog.ge/auth/realms/bog/protocol/openid-connect/token" 401 POST

# --- PSD2 / Open Banking ---
echo "▸ Checking PSD2 / Open Banking..."
check_endpoint "PSD2 Sandbox Base"       "https://xs2a-sandbox.bog.ge"                                 200
check_endpoint "PSD2 Consents"           "https://xs2a-sandbox.bog.ge/0.8/psd2/v1/consents"            401 POST
check_endpoint "OAuth Discovery"         "https://api.bog.ge/.well-known/oauth-authorization-server"   200

# --- Installment API ---
echo "▸ Checking Installment API..."
check_endpoint "Installment Base"        "https://installment.bog.ge"                                  200
check_endpoint "Installment Token"       "https://installment.bog.ge/v1/oauth2/token"                  401 POST

# --- BOG-ID ---
echo "▸ Checking BOG-ID..."
check_endpoint "BOG-ID Auth Page"        "https://account.bog.ge/auth/realms/bog-id/protocol/openid-connect/auth" 200
check_endpoint "BOG-ID Customer Data"    "https://bogid.bog.ge/v1/customer-data"                       401

# --- Business Online ---
echo "▸ Checking Business Online..."
check_endpoint "BOnline API Base"        "https://api.businessonline.ge"                               200
check_endpoint "BOnline Auth"            "https://account.bog.ge/auth/realms/bog/protocol/openid-connect/token" 401 POST

# --- SDK / Static ---
echo "▸ Checking SDK / Static resources..."
check_endpoint "BOG SDK JS"              "https://webstatic.bog.ge/bog-sdk/bog-sdk.js"                 200

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

# Exit code: 0 if no failures, 1 if any failed
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
