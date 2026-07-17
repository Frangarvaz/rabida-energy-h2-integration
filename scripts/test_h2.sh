#!/bin/bash
# ─────────────────────────────────────────────────────────────
# Rábida Energy H₂ Integration Hub — Integration Test
# Sends a test payload to SAP BTP Integration Suite iFlow
# ─────────────────────────────────────────────────────────────
#
# Required environment variables:
#   BTP_AUTH_URL    — OAuth token endpoint (e.g. https://<subaccount>.authentication.<region>.hana.ondemand.com/oauth/token)
#   BTP_CLIENT_ID  — Service key client_id
#   BTP_CLIENT_SECRET — Service key client_secret
#   BTP_IFLOW_URL  — iFlow HTTP endpoint (e.g. https://<subaccount>.it-cpitrial05-rt.cfapps.<region>.hana.ondemand.com/http/h2-certification)
#
# Usage:
#   export BTP_AUTH_URL="https://..."
#   export BTP_CLIENT_ID="sb-..."
#   export BTP_CLIENT_SECRET="..."
#   export BTP_IFLOW_URL="https://..."
#   bash scripts/test_h2.sh
# ─────────────────────────────────────────────────────────────

set -euo pipefail

# Validate env vars
for var in BTP_AUTH_URL BTP_CLIENT_ID BTP_CLIENT_SECRET BTP_IFLOW_URL; do
  if [ -z "${!var:-}" ]; then
    echo "❌ Missing environment variable: $var"
    echo "   See scripts/README.md for setup instructions."
    exit 1
  fi
done

echo "🔑 Requesting OAuth token..."
TOKEN=$(curl -s -X POST "$BTP_AUTH_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials" \
  -d "client_id=$BTP_CLIENT_ID" \
  -d "client_secret=$BTP_CLIENT_SECRET" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")

echo "✅ Token obtained"

echo "📡 Fetching CSRF token..."
curl -s -X GET "$BTP_IFLOW_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-csrf-token: fetch" \
  -c /tmp/sap_cookies.txt \
  -D /tmp/sap_headers.txt > /dev/null

CSRF=$(grep -i x-csrf-token /tmp/sap_headers.txt | awk '{print $2}' | tr -d '\r')
echo "✅ CSRF: $CSRF"

echo "🚀 Sending test payload to iFlow..."
curl -X POST "$BTP_IFLOW_URL" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "x-csrf-token: $CSRF" \
  -b /tmp/sap_cookies.txt \
  -d '{
    "sensor": "SCADA-001",
    "plant": "RABIDA-H2-01",
    "h2_volume_kg": 4200,
    "purity_pct": 99.98,
    "energy_source": "solar"
  }' \
  -w "\n\n📊 HTTP Status: %{http_code}\n⏱  Time: %{time_total}s\n" \
  -s

echo ""
echo "✅ Integration test complete"
