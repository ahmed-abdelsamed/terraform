resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  address_prefixes     = ["10.0.0.0/19"]
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.azurerm_virtual_network
  depends_on = [ azurerm_virtual_network.this ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  address_prefixes     = ["10.0.32.0/19"]
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.azurerm_virtual_network
  depends_on = [ azurerm_virtual_network.this ]
}

# If you want to use existing subnet
# data "azurerm_subnet" "subnet1" {
#   name                 = "subnet1"
#   virtual_network_name = "main"
#   resource_group_name  = "tutorial"
# }

# output "subnet_id" {
#   value = data.azurerm_subnet.subnet1.id
# }
