provider "azurerm" {
  features {}
}

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
    tenant_id = module.mysql_example.identity_tenant_id
    object_id = module.mysql_example.identity_object_id

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

  # active_directory_administrator_object_id = "XX-XXXX-XXXX-XXX-XXX"
  # active_directory_administrator_tenant_id = "XX-XXXX-XXXX-XXX-XXX"

  kv_workflow_enable = false
  # kv_workflow_name             = "XXXXX"
  # kv_workflow_rg               = "XX-XXXX-XXXX-XXX-XXX"
  # kv_workflow_salogging_rg     = "XX-XXXX-XXXX-XXX-XXX"

  sku_name       = "GP_Gen5_4"
  mysql_version  = "8.0"
  storagesize_mb = 512000

  location       = "canadacentral"
  resource_group = "mysql-dev-rg"
  subnet_ids     = []

  ip_rules       = []
  firewall_rules = []

  vnet_cidr   = "172.15.0.0/16"
  vnet_enable = false
  vnet_name   = "mysql-vnet"
  vnet_rg     = "XX-XXXX-XXXX-XXX-XXX"

  subnet_enable           = false
  subnet_name             = "mysql-subnet"
  subnet_address_prefixes = ["172.15.8.0/22"]

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  key_vault_id                     = azurerm_key_vault.keyvault.id

  diagnostics = {
    destination   = ""
    eventhub_name = ""
    logs          = ["all"]
    metrics       = ["all"]
  }

  emails = []

  tags = {
    "tier" = "k8s"
  }
}
