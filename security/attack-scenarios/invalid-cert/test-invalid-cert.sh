# security/attack-scenarios/invalid-cert/test-invalid-cert.sh
# WHY: Show certificate validation failure when a workload uses invalid identity.
openssl s_client -connect order-service.sentinelsecurity.svc.cluster.local:8000 -showcerts || true
# In the mesh this would result in mTLS handshake failure; validate via istio metrics and pod logs.
