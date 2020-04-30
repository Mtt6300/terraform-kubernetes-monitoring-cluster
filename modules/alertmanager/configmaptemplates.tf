resource "kubernetes_config_map" "configmap_template" {
  metadata {
    name = "alertmanager-templates"
    namespace = var.monitoring_name_space
  }
  data = {
    "default.tmpl" = "${file("${path.module}/default.tmpl")}"
  }

}
