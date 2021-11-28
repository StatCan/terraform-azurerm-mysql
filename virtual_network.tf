#########################################################
# vnet_create (used for storage account network rule)
# => ``null` then no vnet created or attached (default)
# => ``true` then enable creation of new vnet
# => ``false` then point to existing vnet
#########################################################

resource "azurerm_virtual_network" "mysql" {
  count = (var.vnet_create == true) ? 1 : 0

  name                = var.vnet_name
  location            = var.vnet_rg
  resource_group_name = var.resource_group
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "mysql" {
  count = (var.vnet_create == true) ? 1 : 0

  name                 = var.subnet_name
  resource_group_name  = var.vnet_rg
  virtual_network_name = var.vnet_create ? azurerm_virtual_network.mysql[0].name : data.azurerm_virtual_network.mysql[0].name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
}
