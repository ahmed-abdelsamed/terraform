resource "local_file" "kubeconfig" {
  depends_on   = [azurerm_kubernetes_cluster.aks_cluster]
  filename     = "kubeconfig"
  content      = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}


output "aks_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}
