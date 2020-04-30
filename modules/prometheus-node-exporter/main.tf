
resource "helm_release" "prometheus-node-exporter" {
  #https://github.com/prometheus/node_exporter
  name  = "prometheus-node-exporter"
  repository = var.helm_stable
  chart = "prometheus-node-exporter"
  namespace = var.monitoring_name_space
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  atomic = true
  cleanup_on_fail = true

}
