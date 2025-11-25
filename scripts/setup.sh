# scripts/setup.sh
# WHY: One-command local setup (kind/minikube + istio + spire + monitoring + build images)
set -e
# Basic flags
MINIKUBE=${MINIKUBE:-false}

echo "1/7 - Creating cluster (kind) ..."
if [ "$MINIKUBE" = "true" ]; then
  echo "Minikube path not fully automated in this demo; ensure minikube is started"
else
  kind create cluster --name sentinelsecurity || true
fi

echo "2/7 - Build container images locally..."
# Build images and load into kind
docker build -t sentinelsecurity/frontend:latest ./apps/frontend
docker build -t sentinelsecurity/api-gateway:latest ./apps/api-gateway
docker build -t sentinelsecurity/user-service:latest ./apps/user-service
docker build -t sentinelsecurity/order-service:latest ./apps/order-service
if [ "$MINIKUBE" != "true" ]; then
  kind load docker-image sentinelsecurity/frontend:latest --name sentinelsecurity
  kind load docker-image sentinelsecurity/api-gateway:latest --name sentinelsecurity
  kind load docker-image sentinelsecurity/user-service:latest --name sentinelsecurity
  kind load docker-image sentinelsecurity/order-service:latest --name sentinelsecurity
fi

echo "3/7 - Install Istio (using istioctl) ..."
istioctl install --set profile=demo -y

echo "4/7 - Deploy SPIRE (simplified Helm) ..."
helm upgrade --install spire ./infrastructure/helm/spire --namespace spire --create-namespace

echo "5/7 - Create namespaces and apply network policies..."
kubectl create ns sentinelsecurity || true
kubectl label namespace sentinelsecurity istio-injection=enabled --overwrite
kubectl apply -f security/network-policies/default-deny.yaml
kubectl apply -f security/network-policies/*.yaml

echo "6/7 - Deploy monitoring stack (Prometheus/Grafana/Jaeger via Helm charts)"
helm upgrade --install monitoring kube-prometheus-stack --repo https://prometheus-community.github.io/helm-charts --namespace monitoring --create-namespace

echo "7/7 - All done. Use ./scripts/deploy.sh to deploy apps"
