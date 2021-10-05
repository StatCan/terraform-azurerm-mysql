locals {
  mysql_diag = {
    storage_account_id = var.kv_workflow_enable ? data.azurerm_storage_account.saloggingname[0].id : azurerm_storage_account.mysql[0].id
    metric             = ["all"]
    log                = ["all"]
  }
}

resource "azurerm_key_vault" "mysql" {
  count = var.kv_create ? 1 : 0

  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.kv_rg
  enabled_for_disk_encryption = true
  tenant_id                   = var.kv_tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  soft_delete_enabled         = true

  sku_name = "standard"

  access_policy {
    tenant_id = azurerm_mysql_server.mysql.identity[0].tenant_id
    object_id = azurerm_mysql_server.mysql.identity[0].principal_id

    key_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
      "wrapKey",
      "unwrapKey",
    ]

    secret_permissions = []

    storage_permissions = []
  }

  access_policy {
    tenant_id = var.kv_tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "list",
      "update",
      "create",
      "import",
      "delete",
      "recover",
      "backup",
      "restore",
      "wrapKey",
      "unwrapKey",
    ]

    secret_permissions = []

    storage_permissions = []
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = [var.subnet_create ? azurerm_subnet.mysql[0].id : data.azurerm_subnet.mysql[0].id]
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [tags]
  }
}

data "azurerm_monitor_diagnostic_categories" "mysql_diag_cat" {
  count = var.kv_create ? 1 : 0

  resource_id = azurerm_key_vault.mysql[0].id
}

resource "azurerm_monitor_diagnostic_setting" "mysql_diag_setting" {
  count = var.kv_create ? 1 : 0

  name               = "${var.name}-keyvault-diag"
  target_resource_id = azurerm_key_vault.mysql[0].id
  storage_account_id = local.mysql_diag.storage_account_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.mysql_diag_cat[0].logs

    content {
      category = log.value
      enabled  = contains(local.mysql_diag.log, "all") || contains(local.mysql_diag.log, log.value)

      retention_policy {
        enabled = true
        days    = 90
      }
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.mysql_diag_cat[0].metrics

    content {
      category = metric.value
      enabled  = contains(local.mysql_diag.metric, "all") || contains(local.mysql_diag.metric, metric.value)

      retention_policy {
        enabled = true
        days    = 90
      }
    }
  }
}
