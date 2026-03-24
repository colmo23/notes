# Penetration Test Methodology

## Phase Checklist

### Phase 1 — Recon
- [ ] Port/service scan (nmap)
- [ ] Technology fingerprint (whatweb, response headers)
- [ ] TLS/cert audit (cipher suites, expiry, SAN)
- [ ] Subdomain enumeration
- [ ] Directory/endpoint enumeration (gobuster, ffuf)
- [ ] OpenAPI/Swagger discovery
- [ ] Keycloak OIDC discovery doc dump
- [ ] Source map / JS file analysis

### Phase 2 — Authentication & Authorization
- [ ] Obtain valid access token
- [ ] Decode and analyze JWT (alg, claims, exp)
- [ ] Test JWT `none` algorithm
- [ ] Test RS256 → HS256 algorithm confusion
- [ ] Test JWT claim tampering (sub, roles, scope)
- [ ] Keycloak default credentials (admin/admin, etc.)
- [ ] Implicit flow enabled?
- [ ] PKCE enforced for public clients?
- [ ] redirect_uri open redirect
- [ ] Token endpoint brute force / lockout
- [ ] Refresh token rotation / reuse
- [ ] Account enumeration via error messages
- [ ] Keycloak admin API unauthenticated access
- [ ] Self-registration enabled?
- [ ] Forgot password flow weaknesses

### Phase 3 — Web Application (OWASP Top 10)
- [ ] Broken Object Level Authorization (BOLA/IDOR)
- [ ] Broken Function Level Authorization
- [ ] SQL injection (manual + sqlmap)
- [ ] XSS (reflected, stored, DOM)
- [ ] SSRF (internal k8s metadata, postgres, keycloak)
- [ ] XXE
- [ ] CSRF (check SameSite, CSRF tokens)
- [ ] Insecure direct object reference
- [ ] Mass assignment
- [ ] Security headers (CSP, HSTS, X-Frame, etc.)
- [ ] CORS misconfiguration
- [ ] Rate limiting / no lockout

### Phase 4 — Kubernetes
- [ ] API server unauthenticated access
- [ ] RBAC audit (wildcard verbs, cluster-admin bindings)
- [ ] ServiceAccount token exfiltration
- [ ] Privileged containers / root containers
- [ ] hostPID / hostNetwork / hostPath mounts
- [ ] Network policy coverage
- [ ] Secrets enumeration (base64 decode)
- [ ] etcd access
- [ ] CIS benchmark (kube-bench)
- [ ] Node metadata service reachable from pods
- [ ] Container escape vectors

### Phase 5 — Database
- [ ] Default/weak credentials
- [ ] PostgreSQL superuser?
- [ ] File read/write (COPY, pg_read_file)
- [ ] SQL injection from web layer (sqlmap)
- [ ] pg_hba.conf trust entries
- [ ] Sensitive data in plaintext
- [ ] SECURITY DEFINER function abuse
- [ ] Privilege escalation paths

## CVSS Scoring Reference

| Score | Severity |
|-------|----------|
| 9.0–10.0 | Critical |
| 7.0–8.9  | High |
| 4.0–6.9  | Medium |
| 0.1–3.9  | Low |
| 0.0      | Informational |
