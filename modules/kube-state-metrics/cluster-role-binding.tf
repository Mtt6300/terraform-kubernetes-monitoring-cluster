resource "kubernetes_cluster_role_binding" "clisterRoleBinding" {
  metadata {
    name = "kube-state-metrics"
    # namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" =  "kube-state-metrics"
      "app.kubernetes.io/version" = "latest"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "kube-state-metrics"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kube-state-metrics"
    namespace = var.kubestate_name_space
  }
}
