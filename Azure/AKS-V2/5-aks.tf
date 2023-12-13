resource "azurerm_user_assigned_identity" "base" {
  name                = "base"
  location            = local.region
  resource_group_name = local.resource_group_name
  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_role_assignment" "base" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.base.principal_id
  depends_on = [ azurerm_user_assigned_identity.base ]
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${local.env}-${local.eks_name}"
  location            = local.region
  resource_group_name = local.resource_group_name
  dns_prefix          = "prodaks1"

  kubernetes_version        = local.eks_version
  automatic_channel_upgrade = "stable"
  private_cluster_enabled   = false
  node_resource_group       = "${local.resource_group_name}-${local.env}-${local.eks_name}"

  # It's in Preview
  # api_server_access_profile {
  #   vnet_integration_enabled = true
  #   subnet_id                = azurerm_subnet.subnet1.id
  # }

  # For production change to "Standard" 
  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  default_node_pool {
    name                 = "general"       ## system mode
    vm_size              = "Standard_D2_v2"
    vnet_subnet_id       = azurerm_subnet.subnet1.id
    orchestrator_version = local.eks_version
    type                 = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    node_count           = 1
    min_count            = 1
    max_count            = 10

    node_labels = {
      role = "general"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.base.id]
  }

  tags = {
    env = local.env
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  depends_on = [
    azurerm_role_assignment.base
  ]
}
resource "azurerm_kubernetes_cluster_node_pool" "user" {     ## user mode (Worker)
  name = "agentpool"
  count = 1
  enable_auto_scaling = true
  //os_disk_type = 
  os_type = "Linux"
  vm_size = "Standard_D2_v2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  max_count = 10
  min_count = 1
  node_count = 1
  max_pods = 100
  mode = "User"
  vnet_subnet_id       = azurerm_subnet.subnet1.id
  tags = {
    env = local.env
  }
   lifecycle {
    ignore_changes = [
      tags,
    ]
  }
   depends_on = [
    azurerm_role_assignment.base
  ]
}

