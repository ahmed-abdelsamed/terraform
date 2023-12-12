resource "azurerm_resource_group" "prod_RG_ams" {   
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_container_registry" "prodcr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
  depends_on = [ azurerm_kubernetes_cluster.aks_cluster ]
}
/*
resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.prodcr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks_cluster.id
  skip_service_principal_aad_check = true
  depends_on = [ azurerm_container_registry.prodcr ]
}
*/
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.prod_RG_ams.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    # availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" 
  }
}
