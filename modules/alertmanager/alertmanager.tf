resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_config_map.configmap,kubernetes_config_map.configmap_template]

  metadata {
    name = "alertmanager"
    namespace = var.monitoring_name_space
    annotations = {
      "configmap.reloader.stakater.com/reload" = "alertmanager-config"
      "configmap.reloader.stakater.com/reload" = "alertmanager-templates"
    }


  }

  spec {
    replicas = var.alertmanager_replica
    selector {
      match_labels = {
        app = "alertmanager"
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
          app = "alertmanager"
        }
      }

      spec {
        container {
          name  = "alertmanager"
          image = "prom/alertmanager:latest"
          args = ["--config.file=/etc/alertmanager/config.yml","--storage.path=/alertmanager"]

          port {
            name = "alertmanager"
            container_port = 9093
          }

          volume_mount {
            name = "config-volume"
            mount_path = "/etc/alertmanager"
          }

          volume_mount {
            name = "templates-volume"
            mount_path = "/etc/alertmanager-templates"
          }
          volume_mount {
            name = "alertmanager"
            mount_path = "/alertmanager"
          }
        }
        volume {
          name = "config-volume"
          config_map{
            name = "alertmanager-config"
          }
        }

        volume {
          name = "templates-volume"
          config_map{
            name = "alertmanager-templates"
          }
        }

        volume {
          name = "alertmanager"
          empty_dir {}
        }
        # node_selector = {
        #   type = "master"
        # }

      }
    }
  }
}



resource "kubernetes_service" "service" {
  metadata {
    name = "alertmanager"
    namespace = var.monitoring_name_space
    annotations = {
      "prometheus.io/scrape" = "true"
      "prometheus.io/path"=   "/"
      "prometheus.io/port" = "8080"
    }

  }
  spec {
    selector = {
      app = "alertmanager"
    }
    port {
      port = 9093
      target_port = 9093
      node_port =  var.alertmanager_node_port
    }
    type = var.alertmanager_service_type
  }
}
