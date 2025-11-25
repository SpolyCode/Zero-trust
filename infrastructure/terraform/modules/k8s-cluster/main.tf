# infrastructure/terraform/modules/k8s-cluster/main.tf
# WHY: Skeleton for cloud provider cluster (GKE/EKS/AKS). Keep credentials and state secure.
variable "provider" { type = string }
# Provider-specific resources to create cluster. In this demo we do not create real resources by default.
output "kubeconfig" {
  value = "REPLACE_WITH_PROVIDER_MODULE_OUTPUT"
}
