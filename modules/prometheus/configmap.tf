resource "kubernetes_config_map" "configmap" {
  metadata {
    name = "prometheus-server-conf"
    namespace = var.monitoring_name_space
    labels = {
      name = "prometheus-server-conf"
    }
  }
  data = {
    "prometheus.rules" = "${file("${path.module}/prometheus.rules.yml")}"
    "prometheus.yml" = "${file("${path.module}/prometheus.yml")}"
  }

}
