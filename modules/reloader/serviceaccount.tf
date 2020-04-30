resource "kubernetes_service_account" "service-account" {
  metadata {
    name = "config-reloader"
    namespace = var.reloader_name_space
    labels = {
      "app" =  "config-reloader"
      "chart" = "reloader-v0.0.58"
      "release" = "reloader"
      "heritage" = "Tiller"
    }
  }

}
