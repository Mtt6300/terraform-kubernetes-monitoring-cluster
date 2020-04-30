resource "kubernetes_deployment" "deployment" {

  metadata {
    name = "config-reloader"
    namespace = var.reloader_name_space
    labels = {
      "app" =  "config-reloader"
      "chart" =  "reloader-v0.0.58"
      "release" =  "reloader"
      "heritage" =  "Tiller"
      "group" =  "com.stakater.platform"
      "provider" =  "stakater"
      "version" =  "v0.0.58"
    }
  }
  spec {
    replicas = 1
    revision_history_limit = 2
    selector {
      match_labels = {
        "app" =  "config-reloader"
        "release" =  "reloader"
      }
    }

    template {
      metadata {
        labels = {
          "app" =  "config-reloader"
          "chart" =  "reloader-v0.0.58"
          "release" =  "reloader"
          "heritage" =  "Tiller"
          "group" =  "com.stakater.platform"
          "provider" =  "stakater"
          "version" =  "v0.0.58"
        }
      }
      spec {
        container {
          image = "stakater/reloader:v0.0.58"
          image_pull_policy =  "IfNotPresent"
          name  = "config-reloader"

    }
    automount_service_account_token = true
    service_account_name  = "config-reloader"
  }
    }
}
}
