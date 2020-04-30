resource "kubernetes_service_account" "service-account" {
  metadata {
    name = "kube-state-metrics"
    namespace = var.kubestate_name_space
    labels = {
      "app.kubernetes.io/name" =  "kube-state-metrics"
      "app.kubernetes.io/version" = "latest"
    }
  }

}
