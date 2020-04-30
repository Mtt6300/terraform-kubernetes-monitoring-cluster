resource "kubernetes_config_map" "configmap" {
  metadata {
    name = "alertmanager-config"
    namespace = var.monitoring_name_space
  }
  data = {
    "config.yml" = "${file("${path.module}/configmain.yml")}"
  }

}
