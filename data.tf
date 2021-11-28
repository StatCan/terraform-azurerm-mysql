data "azurerm_client_config" "current" {}

############################################################
# kv_db_create (used for customer managed key)
# => ``null` then no key vault created or attached (default)
# => ``true` then enable creation of new key vault
# => ``false` then point to existing key vault
############################################################

data "azurerm_key_vault" "db" {
  count = (var.kv_db_create == false) ? 1 : 0

  name                = var.kv_db_name
  resource_group_name = var.kv_db_rg
}

######################################################################
# kv_pointer_enable (pointers in key vault for secrets state)
# => ``true` then state from key vault is used for creation
# => ``false` then state from terraform is used for creation (default)
######################################################################

data "azurerm_key_vault" "pointer" {
  count = var.kv_pointer_enable ? 1 : 0

  name                = var.kv_pointer_name
  resource_group_name = var.kv_pointer_rg
}

data "azurerm_key_vault_secret" "pointer_sqladmin_password" {
  count = var.kv_pointer_enable ? 1 : 0

  name         = var.kv_pointer_sqladmin_password
  key_vault_id = data.azurerm_key_vault.pointer[count.index].id
}

data "azurerm_key_vault_secret" "pointer_logging_name" {
  count = var.kv_pointer_enable ? 1 : 0

  name         = var.kv_pointer_logging_name
  key_vault_id = data.azurerm_key_vault.pointer[count.index].id
}

data "azurerm_storage_account" "pointer_logging_name" {
  count = var.kv_pointer_enable ? 1 : 0

  name                = data.azurerm_key_vault_secret.pointer_logging_name[count.index].value
  resource_group_name = var.kv_pointer_logging_rg
}

#########################################################
# vnet_create (used for storage account network rule)
# => ``null` then no vnet created or attached (default)
# => ``true` then enable creation of new vnet
# => ``false` then point to existing vnet
#########################################################

data "azurerm_virtual_network" "mysql" {
  count = (var.vnet_create == false) ? 1 : 0

  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

data "azurerm_subnet" "mysql" {
  count = (var.vnet_create == false) ? 1 : 0

  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}
