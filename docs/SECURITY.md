# docs/SECURITY.md
## Threat Model (summary)
- Threat: Lateral movement from compromised pod/user.
- Controls:
  - mTLS enforced at mesh control-plane (Istio PeerAuthentication STRICT).
  - Workload identity & certificates via SPIRE.
  - AuthorizationPolicies in Istio restrict allowed callers (by SPIFFE principal).
  - Kubernetes NetworkPolicies create network-layer deny-by-default.
  - Egress restricted to Egress Gateway: prevents pods from calling arbitrary internet services.
## Logs & Alerts
- Prometheus alert when failed auth spikes.
- Kiali/Jaeger for tracing suspicious flows.
