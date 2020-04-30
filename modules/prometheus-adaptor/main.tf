resource "helm_release" "prometheus-adaptor" {
  # source = "./prometheus-adapter"
  #https://github.com/DirectXMan12/k8s-prometheus-adapter
  name  = "prometheus-adaptor"
  repository = var.helm_stable
  chart = "prometheus-adapter"
  namespace = var.monitoring_name_space
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  atomic = true
  cleanup_on_fail = true

}
