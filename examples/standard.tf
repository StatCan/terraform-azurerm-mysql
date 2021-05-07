resource "azurerm_key_vault" "keyvault" {
  name                        = "keyvaultname"
  location                    = var.location
  resource_group_name         = var.rg
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  soft_delete_enabled         = true

  sku_name = "standard"

  access_policy {
    tenant_id = module.psqlserver.identity_tenant_id
    object_id = module.psqlserver.identity_object_id

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
    tenant_id = var.tenant_id
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
  tags = {}
}

module "myqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mysql.git?ref=v1.0.0"

  name           = "myqlservername"
  database_names = ["database"]

  dependencies = []

  administrator_login          = "sqladmin"
  administrator_login_password = var.managed_mysql_password

  sku_name       = "GP_Gen5_4"
  mysql_version  = "5.7"
  storagesize_mb = 512000

  location       = var.location
  resource_group = var.rg
  subnet_id      = var.subnet_id
  firewall_rules = []

  active_directory_administrator_object_id = var.active_directory_admin_object_id
  active_directory_administrator_tenant_id = var.active_directory_admin_tenant_id

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  key_vault_id = azurerm_key_vault.keyvault.id
}
