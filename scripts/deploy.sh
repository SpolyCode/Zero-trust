# scripts/deploy.sh
# WHY: Deploy Helm charts for apps + apply Istio/Authorization policies.
set -e
NAMESPACE=sentinelsecurity

echo "Deploying charts..."
helm upgrade --install api-gateway infrastructure/helm/charts/api-gateway --namespace $NAMESPACE --create-namespace
helm upgrade --install user-service infrastructure/helm/charts/user-service --namespace $NAMESPACE
helm upgrade --install order-service infrastructure/helm/charts/order-service --namespace $NAMESPACE
helm upgrade --install frontend infrastructure/helm/charts/frontend --namespace $NAMESPACE

echo "Applying Istio policies..."
kubectl apply -f istio/policies/peer-authentication-strict.yaml
kubectl apply -f istio/policies/api-gateway-authorization.yaml
kubectl apply -f istio/policies/order-policy.yaml
kubectl apply -f istio/policies/user-policy.yaml

echo "Done. Use kubectl -n $NAMESPACE get pods to view status."
