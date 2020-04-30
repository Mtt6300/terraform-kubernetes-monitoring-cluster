# variable "grafana_ingress_host" {
#   type        = string
#   default     = "grafana.winkels.ir"
# }


variable "grafana_service_type" {
  description = "type of kubernetes service for grafana"
  type        = string
  default     = "NodePort"
}


variable "grafana_replica" {
  description = "number of grafana replicas"
  type        = number
  default     = 1
}

# variable "alertmanager_ingress_host" {
#   type        = string
#   default     = "alertmanager.info"
# }


variable "alertmanager_service_type" {
  description = "type of kubernetes service for alertmanager"

  type        = string
  default     = "NodePort"
}

variable "alertmanager_replica" {
  description = "number of alertmanager replicas"
  type        = number
  default     = 1
}


variable "kubestate_replica" {
  description = "number of kube-state-metrics replicas"

  type        = number
  default     = 1
}

variable "prometheus_replica" {
  description = "number of prometheus replicas"
  type        = number
  default     = 2
}

variable "monitoring_name_space" {
  description = "defualt namespaace for monitoring management tooles"
  type        = string
  default     = "monitoring"
}

variable "reloader_name_space" {
  description = "defualt namespaace for config reloader"
  type        = string
  default     = "kube-system"
}

variable "kubestate_name_space" {
  description = "defualt namespaace for metrics collector"

  type        = string
  default     = "kube-system"
}


variable "alertmanager_node_port" {
  description = "port to expose alertmanager service"

  type = number
  default = 31000
}

variable "grafana_node_port" {
  description = "port to expose grafana service"

  type = number
  default = 32000
}


variable "grafana_persistent_volume_claim_storage" {
  description = "grafana storage size"

  type = string
  default = "1Gi"
}

variable "storage_class_name" {
  description = "storageClass for dynamically provisioning"
  type = string
  default = "standard"
}

variable "prometheus_node_port" {
  description = "port to expose prometheus service"

  type = number
  default = 30000
}

variable "prometheus_service_type" {
  description = "type of kubernetes service for prometheus"
  type        = string
  default     = "NodePort"
}

variable "prometheus_persistent_volume_claim_storage" {
  description = "proemtheus storage size"

  type = string
  default = "3Gi"
}
