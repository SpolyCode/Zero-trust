# docs/ARCHITECTURE.md
## Design Decisions
- **Istio** chosen for built-in mTLS, traffic shaping, telemetry.
- **SPIRE/SPIFFE** chosen to provide machine identities independent of cloud providers.
- **FastAPI** used for microservices: lightweight, async, easy OpenTelemetry integration.
- **Helm + Terraform**: Helm for app packaging; Terraform for infra provisioning in cloud.

## Namespace & Labeling
- All apps run in `sentinelsecurity` namespace labeled `istio-injection=enabled`
- ServiceAccounts are named same as apps and mapped to SPIFFE IDs via SPIRE.

## Data Flow
(see README mermaid)
