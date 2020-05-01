resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap]


  metadata {
    name = "prometheus-deployment"
    namespace = var.monitoring_name_space
    labels = {
      app = "prometheus-server"
    }
    annotations = {
      "configmap.reloader.stakater.com/reload" = "prometheus-server-conf"
    }

  }

  spec {
    replicas = var.prometheus_replica
    selector {
      match_labels = {
        app = "prometheus-server"
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
          app = "prometheus-server"
        }
      }

      spec {
        container {
          name  = "prometheus"
          image = "prom/prometheus:latest"
          args = ["--config.file=/etc/prometheus/prometheus.yml","--storage.tsdb.path=/prometheus/"]

          port {
            container_port = 9090
          }

          volume_mount {
            name = "prometheus-config-volume"
            mount_path = "/etc/prometheus/"
          }

          volume_mount {
            name = "prometheus-storage-volume"
            mount_path = "/prometheus/"
          }
        }
        volume {
          name = "prometheus-config-volume"
          config_map{
            default_mode = "0777"
            name = "prometheus-server-conf"
          }
        }
        volume {
          name = "prometheus-storage-volume"
          persistent_volume_claim{
            claim_name = "ptometheus-pvc"
          }
        }

        security_context {
          fs_group = "472"
        }
        automount_service_account_token = true
      # node_selector = {
      #   type = "master"
      # }
      # image_pull_policy = "IfNotPresent"
      }
    }
  }
}


resource "kubernetes_service" "service" {
  metadata {
    name = "prometheus-service"
    namespace = var.monitoring_name_space
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/port" = "9090"

    }

  }
  spec {
    selector = {
      app = "prometheus-server"
    }
    port {
      port = 8080
      target_port = 9090
      node_port =  var.prometheus_node_port
    }

    type = var.prometheus_service_type
  }
}
