# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }

  lifecycle {
    ignore_changes = [
      triggers["my_dependencies"],
    ]
  }
}

resource "azurerm_key_vault_key" "mysql" {
  name         = "${var.name}-tfex-key"
  key_vault_id = var.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

resource "azurerm_mysql_server" "mysql" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  version    = var.mysql_version
  storage_mb = var.storagesize_mb

  auto_grow_enabled            = true
  backup_retention_days        = 35
  geo_redundant_backup_enabled = false
  infrastructure_encryption_enabled = false

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

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
  server_id        = azurerm_mysql_server.mysql.id
  key_vault_key_id = azurerm_key_vault_key.mysql.id
}

resource "azurerm_mysql_database" "mysql" {
  count               = length(var.database_names)
  name                = var.database_names[count.index]
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_active_directory_administrator" "mysql" {
  server_name         = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group
  login               = "sqladmin"
  tenant_id           = var.active_directory_administrator_object_id
  object_id           = var.active_directory_administrator_tenant_id
}

// Configure Server Logs
//
// https://docs.microsoft.com/en-us/azure/mysql/concepts-query-store
//

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

// Configure Performance
//

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

// Configure Networking
//

resource "azurerm_mysql_firewall_rule" "mysql" {
  count               = length(var.firewall_rules)
  name                = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  start_ip_address    = var.firewall_rules[count.index]
  end_ip_address      = var.firewall_rules[count.index]
}

resource "azurerm_mysql_virtual_network_rule" "mysql" {
  name                = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group
  server_name         = azurerm_mysql_server.mysql.name
  subnet_id           = var.subnet_id
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "azurerm_mysql_server.mysql",
  ]
}
