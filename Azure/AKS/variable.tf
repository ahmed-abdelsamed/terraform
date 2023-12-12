variable "resource_group_name" {
  type = string
  description = "RG name in Azure"
  default = "prod_RG_ams"
}
variable "location" {
  type = string
  default = "UK South"
  description = "Resource Locationin Azure"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default = "aks-cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default = "1.27.7"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default = 2
}

variable "acr_name" {
  type = string
  default = "ProdAcrAms"
}
