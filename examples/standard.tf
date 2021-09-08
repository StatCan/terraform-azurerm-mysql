provider "azurerm" {
  features {}
}

module "mysql_example" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mysql.git?ref=v2.2.0"

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

  kv_db_enable    = false
  # kv_db_tenant_id = "XX-XXXX-XXXX-XXX-XXX"
  # kv_db_name             = "XXXXX"
  # kv_db_rg               = "XX-XXXX-XXXX-XXX-XXX"

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
