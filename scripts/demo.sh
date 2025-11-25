# scripts/demo.sh
# WHY: Video-ready demo script to run commands and show outputs during presentation.
NAMESPACE=sentinelsecurity

echo "1) Show pod status"
kubectl -n $NAMESPACE get pods

echo "2) Port-forward Grafana (for presentation)"
kubectl -n monitoring port-forward svc/grafana 3000:80 &
echo "Open http://localhost:3000 (user/pass may be set in helm values)"

echo "3) Create a demo order (simulate front-end login + order)"
TOKEN=$(kubectl -n $NAMESPACE exec deploy/api-gateway -- curl -s -X POST http://localhost:8080/auth/login -d '{"username":"demo","password":"demo"}' -H "Content-Type: application/json" | jq -r .token)
echo "Token: $TOKEN"
kubectl -n $NAMESPACE exec deploy/frontend -- curl -s -X POST http://api-gateway:8080/orders -H "Authorization: Bearer $TOKEN" -d '{"productId":"p1"}' -H "Content-Type: application/json" || true

echo "4) Run attack scenario (unauthenticated)"
bash security/attack-scenarios/with-zt/attack.sh || true

echo "5) Show Kiali for topology"
kubectl -n istio-system port-forward svc/kiali 20001:20001 &
echo "Open http://localhost:20001 to view service mesh topology"
