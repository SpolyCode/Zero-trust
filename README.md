# SentinelSecurity Zero Trust Framework

A **production-ready, enterprise-grade demo project** showcasing a modern Zero Trust architecture implemented on Kubernetes.  
The project leverages **Istio** for service mesh capabilities, **SPIFFE/SPIRE** for secure service identity, and a comprehensive observability stack including **Prometheus**, **Grafana**, **Jaeger**, and **Kiali**.  
A small E-Commerce microservice application is included to demonstrate real-world usage.

---

## 🚀 Project Overview

Zero Trust is an increasingly vital security paradigm where **no entity is trusted by default, whether inside or outside the network perimeter**.  
This framework implements Zero Trust principles end-to-end by securing service communications, identities, and access policies in a Kubernetes environment.

The project showcases:

- End-to-end encrypted service-to-service communication with **mTLS** enforced by Istio  
- Strong service identity management via **SPIFFE/SPIRE**  
- Granular access control with **Istio AuthorizationPolicies** and **Kubernetes NetworkPolicies**  
- End-to-end observability with distributed tracing, metrics collection, and mesh topology visualization  
- A fully automated **CI/CD pipeline** ensuring code quality, security, and streamlined deployments  

---

## 🎯 Goals

- Demonstrate a complete Zero Trust architecture with real microservices  
- Provide a reusable, production-close reference for interviews, portfolios, and internal training  
- Illustrate secure service mesh communication and identity propagation  
- Showcase integrated observability tools for deep insight into system behavior  
- Automate build, test, and deploy workflows with GitHub Actions  

---

## 🏗 Architecture Overview

Below is a textual overview of the system architecture, optimized for GitHub’s markdown rendering constraints.



---

## 🛠 Technologies & Tools

| Area                | Technology                    | Purpose                                    |
|---------------------|------------------------------|--------------------------------------------|
| Service Mesh        | Istio                        | Secure, observable service-to-service communication with mTLS and policy enforcement |
| Service Identity    | SPIFFE / SPIRE               | Strong cryptographic identity for services |
| Distributed Tracing | OpenTelemetry, Jaeger        | Collecting and visualizing request traces  |
| Metrics & Monitoring| Prometheus                   | Metrics scraping and alerting               |
| Visualization       | Grafana, Kiali               | Dashboards and mesh topology visualization  |
| Container Orchestration | Kubernetes                | Container scheduling and management         |
| CI/CD Pipeline      | GitHub Actions               | Automated testing, building, scanning, and deployment |

---

## 🔐 Security Highlights

- **Mutual TLS (mTLS)** encryption ensures all traffic between microservices is confidential and authenticated.  
- **SPIFFE IDs** provide strong, verifiable identities for each service.  
- **AuthorizationPolicies** enforce fine-grained access control based on identity and role.  
- **NetworkPolicies** restrict Kubernetes pod communication at the network layer.  
- **CI/CD Security** includes static code analysis, vulnerability scanning, and SBOM generation.  

---

## 📈 Observability Highlights

- **Distributed tracing** with Jaeger to track requests end-to-end.  
- **Real-time metrics** collection with Prometheus and visualization in Grafana.  
- **Service mesh visualization** with Kiali provides health and dependency insights.  

---

