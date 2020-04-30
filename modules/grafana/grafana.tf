resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap,kubernetes_persistent_volume_claim.pvc]


  metadata {
    name = "grafana"
    namespace = var.monitoring_name_space
    labels = {
      app = "grafana"
    }
    annotations = {
      "configmap.reloader.stakater.com/reload" = "grafana-datasources"
    }

  }

  spec {
    replicas = var.grafana_replica
    selector {
      match_labels = {
        app = "grafana"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge = 1
        max_unavailable = "33%"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }

      spec {
        container {
          name  = "grafana"
          image = "grafana/grafana:latest"
          port {
            name = "grafana"
            container_port = 3000
          }

          resources {
            limits {
              cpu    = "1000m"
              memory = "2Gi"
            }
          requests {
            cpu    = "500m"
            memory = "1Gi"
          }
        }


          volume_mount {
            name = "grafana-storage"
            mount_path = "/var/lib/grafana"
          }

          volume_mount {
            name = "grafana-datasources"
            mount_path = "/etc/grafana/provisioning/datasources"
            read_only = false

          }
        }
        volume {
          name = "grafana-datasources"
          config_map{
            default_mode = "0777"
            name = "grafana-datasources"
          }
        }
        volume {
          name = "grafana-storage"
          persistent_volume_claim{
            claim_name = "grafana-pvc"
          }
        }
      automount_service_account_token = true
      # node_selector = {
      #   type = "master"
      # }

      }
    }
  }
}


resource "kubernetes_service" "service" {
  metadata {
    name = "grafana"
    namespace = var.monitoring_name_space
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port" = "3000"
    }

  }
  spec {
    selector = {
      app = "grafana"
    }
    port {
      port = 3000
      target_port = 3000
      node_port =  var.grafana_node_port
    }

    type = var.grafana_service_type
  }
}
