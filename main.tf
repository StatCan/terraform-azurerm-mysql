resource "azurerm_key_vault_key" "mysql" {
  count = (var.kv_db_create != null) ? 1 : 0

  name         = "${var.name}-tfex-key"
  key_vault_id = var.kv_db_create ? azurerm_key_vault.mysql[0].id : data.azurerm_key_vault.db[0].id
  key_type     = var.kv_db_key_type
  key_size     = var.kv_db_key_size
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  tags         = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_mysql_server" "mysql" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  administrator_login          = var.administrator_login
  administrator_login_password = (var.kv_pointer_enable && length(data.azurerm_key_vault_secret.pointer_sqladmin_password) > 0) ? data.azurerm_key_vault_secret.pointer_sqladmin_password[0].value : var.administrator_login_password

  sku_name   = var.sku_name
  version    = var.mysql_version
  storage_mb = var.storagesize_mb

  backup_retention_days        = 35
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  tags = var.tags

  threat_detection_policy {
    disabled_alerts            = []
    email_account_admins       = true
    email_addresses            = var.emails
    enabled                    = var.diagnostics != null
    retention_days             = var.retention_days
    storage_endpoint           = var.kv_pointer_enable ? data.azurerm_storage_account.pointer_logging_name[0].primary_blob_endpoint : azurerm_storage_account.mysql[0].primary_blob_endpoint
    storage_account_access_key = var.kv_pointer_enable ? data.azurerm_storage_account.pointer_logging_name[0].primary_access_key : azurerm_storage_account.mysql[0].primary_access_key
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

}

resource "azurerm_mysql_server_key" "mysql" {
  count = (var.kv_db_create != null) ? 1 : 0

  server_id        = azurerm_mysql_server.mysql.id
  key_vault_key_id = azurerm_key_vault_key.mysql[0].id
}

resource "azurerm_mysql_database" "mysql" {
  for_each            = var.databases
  name                = each.key
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  charset             = lookup(each.value, "charset", "utf8")
  collation           = lookup(each.value, "collation", "utf8_unicode_ci")
}

resource "azurerm_mysql_active_directory_administrator" "mysql" {
  server_name         = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group
  login               = "sqladmin"
  tenant_id           = var.active_directory_administrator_tenant_id
  object_id           = var.active_directory_administrator_object_id
}

#########################################################################################
# Configure Server Logs
# https://docs.microsoft.com/en-us/azure/mysql/concepts-query-store
#########################################################################################

resource "azurerm_mysql_configuration" "query_store_capture_interval" {
  name                = "query_store_capture_interval"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.query_store_capture_interval
}

resource "azurerm_mysql_configuration" "query_store_capture_mode" {
  name                = "query_store_capture_mode"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.query_store_capture_mode
}

resource "azurerm_mysql_configuration" "query_store_capture_utility_queries" {
  name                = "query_store_capture_utility_queries"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.query_store_capture_utility_queries
}

resource "azurerm_mysql_configuration" "query_store_retention_period_in_days" {
  name                = "query_store_retention_period_in_days"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.query_store_retention_period_in_days
}

#########################################################################################
# Configure Performance
#########################################################################################

resource "azurerm_mysql_configuration" "max_allowed_packet" {
  name                = "max_allowed_packet"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.max_allowed_packet
}

resource "azurerm_mysql_configuration" "innodb_buffer_pool_size" {
  name                = "innodb_buffer_pool_size"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.innodb_buffer_pool_size
}

resource "azurerm_mysql_configuration" "table_definition_cache" {
  name                = "table_definition_cache"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.table_definition_cache
}

resource "azurerm_mysql_configuration" "table_open_cache" {
  name                = "table_open_cache"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.table_open_cache
}

resource "azurerm_mysql_configuration" "redirect_enabled" {
  name                = "redirect_enabled"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  value               = var.redirect_enabled
}

#########################################################################################
# Configure Networking
#########################################################################################

resource "azurerm_mysql_firewall_rule" "mysql" {
  for_each            = toset(var.firewall_rules)
  name                = replace(each.key, ".", "-")
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = each.key
  end_ip_address      = each.key
}

resource "azurerm_mysql_virtual_network_rule" "mysql" {
  for_each            = toset(var.subnet_ids)
  name                = "r-${md5(each.key)}"
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  subnet_id           = each.key
}
