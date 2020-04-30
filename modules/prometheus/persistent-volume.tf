resource "kubernetes_persistent_volume_claim" "pvc" {

  metadata {
    name = "ptometheus-pvc"
    namespace = var.monitoring_name_space
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.prometheus_persistent_volume_claim_storage
      }
    }
    storage_class_name = var.storage_class_name
  }
}
