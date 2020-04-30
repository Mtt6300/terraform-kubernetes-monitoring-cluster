resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "kube-state-metrics"
    namespace = var.kubestate_name_space
    labels = {
      "app.kubernetes.io/name" =  "kube-state-metrics"
      "app.kubernetes.io/version" = "latest"
    }
  }
  spec {
    replicas = var.kubestate_replica
    selector {
      match_labels = {
        "app.kubernetes.io/name" =  "kube-state-metrics"
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
          "app.kubernetes.io/name" =  "kube-state-metrics"
          "app.kubernetes.io/version" = "latest"
        }
      }
      spec {
        container {
          image = "quay.io/coreos/kube-state-metrics:latest"
          name  = "kube-state-metrics"

          port {
            name = "http-metrics"
            container_port = 8080
          }
          port {
            name = "telemetry"
            container_port = 8081
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 5
            timeout_seconds =  5
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 8081
            }
            initial_delay_seconds = 5
            timeout_seconds =  5
          }
      }
        service_account_name  = "kube-state-metrics"
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
    name = "kube-state-metrics"
    namespace = var.kubestate_name_space
    labels = {
      "app.kubernetes.io/name" =  "kube-state-metrics"
      "app.kubernetes.io/version" = "latest"
    }

  }
  spec {
    selector = {
      "app.kubernetes.io/name" = "kube-state-metrics"
    }
    port {
      port = 8080
      name = "http-metrics"
      target_port = "http-metrics"
    }

    port {
      port = 8081
      name = "telemetry"
      target_port = "telemetry"

    }
  cluster_ip = "None"

  }
}
