# Server

variable "active_directory_administrator_object_id" {
  description = "(Optional) The Active Directory Administrator Object ID."
  default     = ""
}

variable "active_directory_administrator_tenant_id" {
  description = "(Optional) The Active Directory Administrator Tenant ID."
  default     = ""
}

variable "administrator_login" {
  description = "(Required) The Administrator Login for the MySQL Server."
}

variable "administrator_login_password" {
  description = "(Required) The Password associated with the administrator_login for the MySQL Server."
}

variable "databases" {
  type        = map(map(string))
  description = "(Required) The name, collation, and character set of the MySQL database(s). (defaults: charset='utf8', collation='utf8_unicode_ci')"
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it."
  type = object({
    destination   = string
    eventhub_name = string
    logs          = list(string)
    metrics       = list(string)
  })
  default = null
}

variable "emails" {
  type        = list(string)
  description = "(Required) List of email addresses that should recieve the security reports."
  default     = []
}

variable "ip_rules" {
  type        = list(string)
  description = "(Required) List of public IP or IP ranges in CIDR Format."
}

variable "firewall_rules" {
  type        = list(string)
  description = "(Required) Specifies the Start IP Address associated with this Firewall Rule."
}

variable "key_type" {
  description = "Type of key to create in the Key Vault."
  default     = "RSA"
}

variable "key_size" {
  type        = number
  description = "Size of key to create in Key Vault."
  default     = 2048
}

variable "key_vault_id" {
  description = "(Optional) The Key Vault id for the Customer Managed Key."
  default     = ""
}

variable "kv_db_enable" {
  description = "(Optional) Enable Key Vault to be used for the Key Vault against the MySQL instance."
  default     = false
}

variable "kv_db_name" {
  description = "(Optional) The Key Vault name to be used for the Key Vault against the MySQL instance."
  default     = ""
}

variable "kv_db_rg" {
  description = "(Optional) The Key Vault resource group to be used for the Key Vault against the MySQL instance."
  default     = ""
}

variable "kv_db_tenant_id" {
  description = "(Required) The Tenant ID to be used for the Key Vault against the MySQL instance."
}

variable "kv_workflow_enable" {
  description = "(Optional) Enable Key Vault workflow for storage of passwords and pointer to logging storage account."
  default     = false
}

variable "kv_workflow_name" {
  description = "(Optional) The Key Vault name."
  default     = ""
}

variable "kv_workflow_rg" {
  description = "(Optional) The Key Vault resource group."
  default     = ""
}

variable "kv_workflow_salogging_rg" {
  description = "(Optional) The Key Vault storage account for logging resource group."
  default     = ""
}

variable "location" {
  description = "(Optional) Specifies the supported Azure location where the resource exists."
  default     = "canadacentral"
}

variable "mysql_version" {
  description = "(Optional) The version of the MySQL Server."
  default     = "8.0"
}

variable "name" {
  description = "(Required) The name of the MySQL Server."
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether or not public network access is allowed for this server."
  default     = false
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the MySQL Server."
}

variable "retention_days" {
  description = "(Optional) Specifies the retention in days for logs for this PostgreSQL Server."
  default     = 90
}

variable "sku_name" {
  description = "(Optional) Specifies the SKU Name for this MySQL Server."
  default     = "GP_Gen5_4"
}

variable "ssl_enforcement_enabled" {
  description = "(Optional) Specifies if SSL should be enforced on connections."
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "(Optional) The mimimun TLS version to support on the server."
  default     = "TLS1_2"
}

variable "storagesize_mb" {
  description = "(Optional)  Specifies the version of MySQL to use."
  default     = 640000
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) The IDs of the subnet that the MySQL server will be connected to."
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

variable "vnet_cidr" {
  description = "Virtual Network CIDR"
  type        = list(string)
  default     = ["172.15.0.0/16"]
}

variable "vnet_enable" {
  description = "(Optional) Enable Virtual Network logic."
  default     = false
}

variable "vnet_name" {
  description = "(Optional) Name for your Virtual Network."
  type        = string
}

variable "vnet_rg" {
  description = "(Optional) The Virtual Network resource group."
  default     = ""
}

variable "subnet_address_prefixes" {
  description = "Virtual Network Address Prefixes"
  type        = list(string)
  default     = ["172.15.8.0/22"]
}

variable "subnet_enable" {
  description = "(Optional) Enable Subnet logic."
  default     = false
}

variable "subnet_name" {
  description = "(Optional) Name for your Subnet."
  type        = string
}

# Parameters

variable "innodb_buffer_pool_size" {
  description = "(Optional) The size in bytes of the buffer pool, the memory area where InnoDB caches table and index data."
  default     = 16106127360
}

variable "max_allowed_packet" {
  description = "(Optional) The maximum size of one packet or any generated/intermediate string."
  default     = 536870912
}

variable "query_store_capture_interval" {
  description = "(Optional) The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated."
  default     = 15
}

variable "query_store_capture_mode" {
  description = "(Optional) The query store capture mode, NONE means do not capture any statements."
  default     = "ALL"
}

variable "query_store_capture_utility_queries" {
  description = "(Optional) Turning ON or OFF to capture all the utility queries that is executing in the system."
  default     = "YES"
}

variable "query_store_retention_period_in_days" {
  description = "(Optional) The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated."
  default     = 7
}

variable "table_definition_cache" {
  description = "(Optional) The number of table definitions (from .frm files) that can be stored in the definition cache."
  default     = 5000
}

variable "table_open_cache" {
  description = "(Optional) The number of open tables for all threads."
  default     = 5000
}
