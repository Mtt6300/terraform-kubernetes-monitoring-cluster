# resource "kubernetes_ingress" "ingress" {
#   metadata {
#     name = "alertmanager"
#     namespace = var.monitoring_name_space
#
#     annotations = {
#       "kubernetes.io/ingress.class" =  "nginx"
#     }
#   }
#   spec {
#     rule {
#       host = var.alertmanager_ingress_host
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
