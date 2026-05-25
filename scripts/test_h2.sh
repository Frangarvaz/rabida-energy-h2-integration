TOKEN=$(curl -s -X POST "https://e7c91510trial.authentication.us10.hana.ondemand.com/oauth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials" \
  -d "client_id=sb-6837bc3e-acdc-416c-9fd5-550aa486b258!b636459|it-rt-e7c91510trial!b26655" \
  -d "client_secret=c9e97676-16a8-43ef-92c3-d4486d5c5617\$vBbMol4C3pFyR1jwkun66PnVoAhf_OrdtlAKSa-ttFQ=" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])")

curl -s -X GET "https://e7c91510trial.it-cpitrial05-rt.cfapps.us10-001.hana.ondemand.com/http/h2-certification" \
  -H "Authorization: Bearer $TOKEN" \
  -H "x-csrf-token: fetch" \
  -c /tmp/sap_cookies.txt \
  -D /tmp/sap_headers.txt > /dev/null

CSRF=$(grep -i x-csrf-token /tmp/sap_headers.txt | awk '{print $2}' | tr -d '\r')
echo "CSRF: $CSRF"

curl -X POST "https://e7c91510trial.it-cpitrial05-rt.cfapps.us10-001.hana.ondemand.com/http/h2-certification" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "x-csrf-token: $CSRF" \
  -b /tmp/sap_cookies.txt \
  -d '{"sensor":"SCADA-001"}' \
  -v
