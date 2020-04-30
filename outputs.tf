# output "grafana_ingress_host" {
#   value       = var.grafana_ingress_host
# }
output "grafana_dashboard_authentication" {
  description = "grafana default authentication"
  value       = "admin:admin"
}
output "grafana_dashboard_node_exporter_1" {
  description = "node exporter dashboard 1"
  value       = "1860"
}
output "grafana_dashboard_node_exporter_2" {
  description = "node exporter dashboard 2"
  value       = "11074"
}
output "grafana_dashboard_deployment" {
  description = "deployment dashboard"
  value       = "8588"
}

output "alertmanager_node_port" {
  description = "alertmanager node port"
  value       = var.alertmanager_node_port
}

output "grafana_node_port" {
  description = "grafana node port"
  value       = var.alertmanager_node_port
}

output "prometheus_node_port" {
  description = "prometheus node port"
  value       = var.alertmanager_node_port
}
