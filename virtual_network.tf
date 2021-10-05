resource "azurerm_virtual_network" "mysql" {
  count = var.vnet_create ? 1 : 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "mysql" {
  count = var.subnet_create ? 1 : 0

  name                 = var.name
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_create ? azurerm_virtual_network.mysql[0].name : data.azurerm_virtual_network.mysql[0].name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
}
