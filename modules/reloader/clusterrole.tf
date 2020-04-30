resource "kubernetes_cluster_role" "clusterRole" {
  metadata {
    name = "config-reloader-role"
    labels = {
      "app" =  "config-reloader"
      "chart" =  "reloader-v0.0.58"
      "release" =  "reloader"
      "heritage" =  "Tiller"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps","secrets"]
    verbs      = ["list", "watch","get"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["daemonsets","deployments"]
    verbs      = ["list", "get","update","patch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["daemonsets","statefulsets","deployments"]
    verbs      = ["list", "get","update","patch"]
  }

}
