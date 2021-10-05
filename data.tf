locals {
  kv_name = var.kv_name
  kv_rg   = var.kv_rg

  kv_workflow_name = var.kv_workflow_name
  kv_workflow_rg   = var.kv_workflow_rg
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "db" {
  count = var.kv_create ? 0 : 1

  name                = local.kv_name
  resource_group_name = local.kv_rg
}

data "azurerm_key_vault" "sqlhstkv" {
  count = (var.diagnostics != null) && var.kv_workflow_enable ? 1 : 0

  name                = local.kv_workflow_name
  resource_group_name = local.kv_workflow_rg
}

data "azurerm_key_vault_secret" "sqlhstsvc" {
  count = (var.diagnostics != null) && var.kv_workflow_enable ? 1 : 0

  name         = "sqlhstsvc"
  key_vault_id = data.azurerm_key_vault.sqlhstkv[count.index].id
}

data "azurerm_key_vault_secret" "saloggingname" {
  count = (var.diagnostics != null) && var.kv_workflow_enable ? 1 : 0

  name         = "saloggingname"
  key_vault_id = data.azurerm_key_vault.sqlhstkv[count.index].id
}

data "azurerm_storage_account" "saloggingname" {
  count = (var.diagnostics != null) && var.kv_workflow_enable ? 1 : 0

  name                = data.azurerm_key_vault_secret.saloggingname[count.index].value
  resource_group_name = var.kv_workflow_salogging_rg
}

data "azurerm_virtual_network" "mysql" {
  count = var.vnet_create ? 0 : 1

  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

data "azurerm_subnet" "mysql" {
  count = var.subnet_create ? 0 : 1

  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}
