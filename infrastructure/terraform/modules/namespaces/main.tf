# infrastructure/terraform/modules/namespaces/main.tf
provider "kubernetes" {}
resource "kubernetes_namespace" "sentinelsecurity" {
  metadata {
    name = "sentinelsecurity"
    labels = { "name"="sentinelsecurity" }
  }
}
