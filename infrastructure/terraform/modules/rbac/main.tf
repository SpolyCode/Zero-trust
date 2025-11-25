# infrastructure/terraform/modules/rbac/main.tf
# WHY: Create minimal RBAC for Helm releases and service accounts.
resource "kubernetes_cluster_role" "helm" {
  metadata { name = "sentinel-helm" }
  rule { api_groups = ["*"]; resources=["*"]; verbs=["get","list","watch"] }
}
