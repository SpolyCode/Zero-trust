# sentinelsecurity-zerotrust/README.md

# SentinelSecurity Zero Trust Framework
**Ein vollständiges, produktionsnahes Demo-Projekt** zur Demonstration einer Zero Trust Architektur auf Kubernetes mit Istio, SPIRE (SPIFFE), Observability (Prometheus, Grafana, Jaeger, Kiali) und einer kleinen E-Commerce Microservice-App.

## Ziel
Dieses Repo ist ein vorzeigbares Demo-Projekt für Interviews und Portfolios. Es zeigt:
- mTLS für alle Service-Kommunikationen via Istio
- Service-Identity via SPIFFE/SPIRE
- Fein granularer AuthorizationPolicy (Istio) & Kubernetes NetworkPolicies
- Observability: Tracing (OpenTelemetry/Jaeger), metrics (Prometheus), mesh topology (Kiali)
- CI/CD Pipeline: Lint, Scan, Build, Push, Deploy, SBOM

---

## Architektur (Mermaid)
```mermaid
flowchart LR
  subgraph cluster_mesh [Istio Service Mesh]
    direction TB
    FE[Frontend (React)] -->|HTTP/HTTPS JWT| APIGW[API Gateway]
    APIGW -->|mTLS + SPIFFE| USER[User Service]
    APIGW -->|mTLS + SPIFFE| ORDER[Order Service]
    ORDER -->|mTLS + SPIFFE| USER
    ORDER -->|DB connection (restricted)| DB[(Database)]
  end
  subgraph cluster_monitoring [Monitoring]
    PROM[Prometheus] --- GRAF[Grafana]
    JA[Jaeger] --- PROM
    KIALI[Kiali] --- ISTIO[Istio Control Plane]
  end
