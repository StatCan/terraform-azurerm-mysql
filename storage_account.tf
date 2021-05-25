# Storage Accounts

resource "azurerm_storage_account" "mysql" {
  count = var.keyvault_enable ? 0 : 1

  name                     = substr("${replace(var.name, "-", "")}mysql", 0, 24)
  location                 = var.location
  resource_group_name      = var.resource_group
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  # enable_blob_encryption = "True"
  # enable_file_encryption = "True"
  access_tier               = "Hot"
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "mysql" {
  count = var.keyvault_enable ? 0 : 1

  name                  = "${replace(var.name, "-", "")}mysql"
  storage_account_name  = azurerm_storage_account.mysql[count.index].name
  container_access_type = "private"
}
