# SentinelSecurity Zero Trust Framework

**Ein vollständiges, produktionsnahes Demo-Projekt** zur Demonstration einer Zero Trust Architektur auf Kubernetes mit:

- **Istio** (Service Mesh, mTLS, Authorization Policies)  
- **SPIFFE/SPIRE** (Service Identity)  
- **Observability** (Prometheus, Grafana, Jaeger, Kiali)  
- Kleine E-Commerce Microservice-App  

---

## 🎯 Projektziel

Dieses Repository dient als vorzeigbares Demo-Projekt für Interviews, Portfolios und Schulungen. Es demonstriert praxisnah:

- Vollständig verschlüsselte Service-Kommunikation via mTLS mit Istio  
- Service-Identität und Authentifizierung über SPIFFE/SPIRE  
- Granulare Authorization Policies mit Istio und Kubernetes Network Policies  
- Umfassende Observability mit Tracing (Jaeger), Metriken (Prometheus) und Mesh-Visualisierung (Kiali)  
- Eine CI/CD-Pipeline zur Automatisierung von Linting, Scanning, Building, Deployment und SBOM-Erstellung  

---

## 🏗 Architekturübersicht

```mermaid
flowchart LR

subgraph Istio_Service_Mesh
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

subgraph Monitoring
    PROM[Prometheus]
    GRAF[Grafana]
    JA[Jaeger]
    ISTIO[Istio Control Plane]
    KIALI[Kiali]

    PROM --- GRAF
    PROM --- JA
    ISTIO --- KIALI
end
