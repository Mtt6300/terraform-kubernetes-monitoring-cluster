# resource "kubernetes_ingress" "ingress" {
#   metadata {
#     name = "grafana"
#     namespace = "monitoring"
#
#     annotations = {
#       "kubernetes.io/ingress.class" =  "nginx"
#     }
#   }
#   spec {
#     rule {
#       host = var.grafana_ingress_host
#       http {
#         path {
#           path = "/"
#
#           backend {
#             service_name = kubernetes_service.service.metadata.0.name
#             service_port = kubernetes_service.service.spec.0.port.0.port
#           }
#         }
#       }
#     }
#   }
# }
