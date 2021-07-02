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

module "mysql_example" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mysql.git?ref=v2.0.0"

  name = "mysqlservername"
  databases = {
    mysqlservername1 = { collation = "utf8_unicode_ci" }
    mysqlservername2 = { charset = "utf8" }
    mysqlservername3 = { charset = "utf8", collation = "utf8_unicode_ci" }
    mysqlservername4 = {}
  }

  administrator_login          = "mysqladmin"
  administrator_login_password = var.administrator_login_password

  keyvault_enable = false

  sku_name       = "GP_Gen5_4"
  mysql_version  = "8.0"
  storagesize_mb = 512000

  location       = "canadacentral"
  environment    = "dev"
  resource_group = "mysql-dev-rg"
  subnet_ids     = [local.containerCCSubnetRef]

  active_directory_administrator_object_id = var.active_directory_administrator_object_id
  active_directory_administrator_tenant_id = var.active_directory_administrator_tenant_id

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  emails = []

  tags = {
    "tier" = "k8s"
  }

  key_vault_id = azurerm_key_vault.keyvault.id
}
