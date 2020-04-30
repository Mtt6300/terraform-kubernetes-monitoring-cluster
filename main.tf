terraform {
  required_providers {
    kubernetes = "~> 1.11"
    helm = "~> 1.1"
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.monitoring_name_space
  }
}

data "helm_repository" "stable" {
  #https://www.terraform.io/docs/providers/helm/d/repository.html
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}


module "prometheus" {
  #https://github.com/prometheus/prometheus
  source = "./modules/prometheus"
  prometheus_replica = var.prometheus_replica
  monitoring_name_space = var.monitoring_name_space
  prometheus_node_port = var.prometheus_node_port
  prometheus_service_type = var.prometheus_service_type
  storage_class_name = var.storage_class_name
  prometheus_persistent_volume_claim_storage = var.prometheus_persistent_volume_claim_storage
  }

module "kube-state-metrics" {
  #https://github.com/kubernetes/kube-state-metrics
  source = "./modules/kube-state-metrics"
  kubestate_replica = var.kubestate_replica
  kubestate_name_space = var.kubestate_name_space
}

module "alertmanager" {
  #https://github.com/prometheus/alertmanager
  source = "./modules/alertmanager"
  # alertmanager_ingress_host = var.alertmanager_ingress_host
  monitoring_name_space = var.monitoring_name_space
  alertmanager_service_type = var.alertmanager_service_type
  alertmanager_replica = var.alertmanager_replica
  alertmanager_node_port = var.alertmanager_node_port

}
#
module "grafana" {
  #https://github.com/grafana/grafana
  source = "./modules/grafana"
  # grafana_ingress_host = var.grafana_ingress_host
  monitoring_name_space = var.monitoring_name_space
  grafana_service_type = var.grafana_service_type
  grafana_replica = var.grafana_replica
  grafana_node_port = var.grafana_node_port
  grafana_persistent_volume_claim_storage = var.grafana_persistent_volume_claim_storage
  storage_class_name= var.storage_class_name

}


module "reloader" {
  # https://github.com/stakater/Reloader
  source = "./modules/reloader"
  reloader_name_space = var.reloader_name_space
}



module "prometheus-adaptor" {
  source = "./modules/prometheus-adaptor"
  monitoring_name_space = var.monitoring_name_space
  helm_stable = data.helm_repository.stable.metadata[0].name

}


module "prometheus-node-exporter" {
  source = "./modules/prometheus-node-exporter"
  monitoring_name_space = var.monitoring_name_space
  helm_stable = data.helm_repository.stable.metadata[0].name


}
