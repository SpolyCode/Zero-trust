# security/attack-scenarios/no-zt/attack.sh
# WHY: Demonstrates lateral movement when mesh security is not enforced.
set -e
# 1) run curl from a pod that's unauthorized — attempt to call order-service directly
kubectl run -it --rm attacker --image=curlimages/curl --restart=Never -- /bin/sh -c "curl -sS http://order-service.sentinelsecurity.svc.cluster.local:8000/orders || true"
# Expectation: Without ZT, call may succeed. With ZT enforced, it should be blocked.
