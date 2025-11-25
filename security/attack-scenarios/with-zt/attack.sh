# security/attack-scenarios/with-zt/attack.sh
# WHY: Attempt the same but after enabling Istio + AuthorizationPolicy; should be blocked.
set -e
kubectl run -it --rm attacker --image=istio/proxyv2 --restart=Never -- /bin/sh -c "curl -sS -H 'Authorization: Bearer somefake' http://order-service.sentinelsecurity.svc.cluster.local:8000/orders || true"
# Check logs/Audit: kubectl logs -n istio-system <istiod-pod> and Kiali/Prometheus for AuthorizationPolicy violation metrics.
