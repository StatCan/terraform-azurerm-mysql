# Storage Accounts

resource "azurerm_storage_account" "mysql" {
  count = var.kv_workflow_enable ? 0 : 1

  name                      = substr("${replace(var.name, "-", "")}mysql", 0, 24)
  location                  = var.location
  resource_group_name       = var.resource_group
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  access_tier               = "Hot"
  enable_https_traffic_only = true
  allow_blob_public_access  = false
  min_tls_version           = "TLS1_2"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [var.subnet_enable ? azurerm_subnet.mysql[0].id : data.azurerm_subnet.mysql[0].id]
    bypass                     = ["AzureServices"]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "mysql" {
  count = var.kv_workflow_enable ? 0 : 1

  name                  = "${replace(var.name, "-", "")}mysql"
  storage_account_name  = azurerm_storage_account.mysql[count.index].name
  container_access_type = "private"
}
