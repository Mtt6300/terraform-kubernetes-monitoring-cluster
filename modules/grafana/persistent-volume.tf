resource "kubernetes_persistent_volume_claim" "pvc" {

  metadata {
    name = "grafana-pvc"
    namespace = var.monitoring_name_space
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.grafana_persistent_volume_claim_storage
      }
    }
    storage_class_name = var.storage_class_name
    # volume_name = "${kubernetes_persistent_volume.pv.metadata.0.name}"
  }
}


# resource "kubernetes_persistent_volume" "pv" {
#   metadata {
#     name = "grafana-pv"
#   }
#   spec {
#     capacity = {
#       storage = "2Gi"
#     }
#     access_modes = ["ReadWriteMany"]
#     local = {
#       path =  "/mnt/disks/ssd1"
#     }
#   }
# }
