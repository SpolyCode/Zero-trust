# SentinelSecurity Zero Trust Framework

**Ein vollständiges, produktionsnahes Demo-Projekt** zur Demonstration einer Zero Trust Architektur auf Kubernetes mit:
- Istio (Service Mesh, mTLS, AuthorizationPolicies)
- SPIFFE/SPIRE (Service Identity)
- Observability (Prometheus, Grafana, Jaeger, Kiali)
- Kleine E-Commerce Microservice-App

---

## 🎯 Ziel

Dieses Repo ist ein vorzeigbares Demo-Projekt für Interviews und Portfolios.  
Es zeigt eine moderne Zero-Trust-Referenzarchitektur mit:

- mTLS für alle Service-Kommunikationen via Istio  
- Service-Identity via SPIFFE/SPIRE  
- Fein granularen AuthorizationPolicies (Istio) & Kubernetes NetworkPolicies  
- Observability:
  - Tracing: OpenTelemetry / Jaeger  
  - Metrics: Prometheus  
  - Mesh Topology: Kiali  
- CI/CD Pipeline: Lint, Scan, Build, Push, Deploy, SBOM  

---

## 🏗 Architektur (Mermaid Diagramm)

```mermaid
flowchart LR

subgraph cluster_mesh
    title Istio Service Mesh
    direction TB

    FE[Frontend (React)]
    APIGW[API Gateway]
    USER[User Service]
    ORDER[Order Service]
    DB[(Database)]

    FE -->|"HTTP/HTTPS JWT"| APIGW
    APIGW -->|"mTLS + SPIFFE"| USER
    APIGW -->|"mTLS + SPIFFE"| ORDER
    ORDER -->|"mTLS + SPIFFE"| USER
    ORDER -->|"DB connection (restricted)"| DB
end

subgraph cluster_monitoring
    title Monitoring

    PROM[Prometheus]
    GRAF[Grafana]
    JA[Jaeger]
    ISTIO[Istio Control Plane]
    KIALI[Kiali]

    PROM --- GRAF
    PROM --- JA
    ISTIO --- KIALI
end
