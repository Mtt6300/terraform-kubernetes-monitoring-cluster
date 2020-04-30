resource "kubernetes_cluster_role_binding" "clisterRoleBinding" {
  metadata {
    name = "config-reloader-role-binding"
    labels = {
      "app" =  "config-reloader"
      "chart" =  "reloader-v0.0.58"
      "release" =  "reloader"
      "heritage" =  "Tiller"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "config-reloader-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "config-reloader"
    namespace = var.reloader_name_space
  }

}
