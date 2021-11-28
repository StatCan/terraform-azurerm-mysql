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

variable "location" {
  description = "(Optional) Specifies the supported Azure location where the resource exists."
  default     = "canadacentral"
}

variable "name" {
  description = "(Required) The name of the MySQL Server."
}

variable "mysql_version" {
  description = "(Required) The version of the MySQL Server."
  default     = "8.0"
}

variable "public_network_access_enabled" {
  description = "(Required) Whether or not public network access is allowed for this server."
  default     = false
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the MySQL Server."
}

variable "retention_days" {
  description = "(Optional) Specifies the retention in days for logs for this MySQL Server."
  default     = 90
}

variable "sku_name" {
  description = "(Required) Specifies the SKU Name for this MySQL Server."
  default     = "GP_Gen5_4"
}

variable "ssl_enforcement_enabled" {
  description = "(Required) Specifies if SSL should be enforced on connections."
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "(Required) The mimimun TLS version to support on the server."
  default     = "TLS1_2"
}

variable "storagesize_mb" {
  description = "(Required) Specifies the version of MySQL to use."
  default     = 640000
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) The IDs of the subnet that the MySQL server will be connected to."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    environment : "dev"
  }
}

############################################################
# kv_db_create (used for customer managed key)
# => ``null` then no key vault created or attached (default)
# => ``true` then enable creation of new key vault
# => ``false` then point to existing key vault
############################################################

variable "kv_db_create" {
  description = "(Optional) Flag kv_db_create can either be `null` (default), `true` (create key vault), or `false` (use existing key vault)."
  default     = null
}

variable "kv_db_name" {
  description = "(Optional) The key vault name to be used when kv_db_create is either set to `true` or `false`."
  default     = null
}

variable "kv_db_rg" {
  description = "(Optional) The key vault resource group to be used when kv_db_create is either set to `true` or `false`."
  default     = null
}

variable "kv_db_tenant_id" {
  description = "(Optional) The key vault tenant id to be used when kv_db_create is either set to `true` or `false`."
  default     = null
}

variable "kv_db_key_size" {
  description = "(Optional) The key vault size to be used when kv_db_create is either set to `true` or `false`."
  type        = number
  default     = 2048
}

variable "kv_db_key_type" {
  description = "(Optional) The key vault type to be used when kv_db_create is either set to `true` or `false`."
  default     = "RSA"
}

######################################################################
# kv_pointer_enable (pointers in key vault for secrets state)
# => ``true` then state from key vault is used for creation
# => ``false` then state from terraform is used for creation (default)
######################################################################

variable "kv_pointer_enable" {
  description = "(Optional) Flag kv_pointer_enable can either be `true` (state from key vault), or `false` (state from terraform)."
  default     = false
}

variable "kv_pointer_name" {
  description = "(Optional) The key vault name to be used when kv_pointer_enable is set to `true`."
  default     = null
}

variable "kv_pointer_rg" {
  description = "(Optional) The key vault resource group to be used when kv_pointer_enable is set to `true`."
  default     = null
}

variable "kv_pointer_logging_name" {
  description = "(Optional) The logging name to be looked up in key vault when kv_pointer_enable is set to `true`."
  default     = null
}

variable "kv_pointer_logging_rg" {
  description = "(Optional) The logging resource group name to be used when kv_pointer_enable is set to `true`."
  default     = null
}

variable "kv_pointer_sqladmin_password" {
  description = "(Optional) The sqladmin password to be looked up in key vault when kv_pointer_enable is set to `true`."
  default     = null
}

#########################################################
# vnet_create (used for storage account network rule)
# => ``null` then no vnet created or attached (default)
# => ``true` then enable creation of new vnet
# => ``false` then point to existing vnet
#########################################################

variable "vnet_create" {
  description = "(Optional) Flag vnet_create can either be `null` (default), `true` (create vnet), or `false` (use existing vnet)."
  default     = null
}

variable "vnet_cidr" {
  description = "Virtual Network CIDR."
  type        = string
  default     = "172.15.0.0/16"
}

variable "vnet_name" {
  description = "(Optional) The vnet name to be used when vnet_create is either set to `true` or `false`."
  type        = string
  default     = null
}

variable "vnet_rg" {
  description = "(Optional) The vnet resource group to be used when vnet_create is either set to `true` or `false`."
  default     = null
}

variable "subnet_name" {
  description = "(Optional) The subnet name to be used when vnet_create is either set to `true` or `false`."
  type        = string
  default     = null
}

variable "subnet_address_prefixes" {
  description = "Virtual Network Address Prefixes."
  type        = list(string)
  default     = ["172.15.8.0/22"]
}

#########################################################
# Parameters
#########################################################

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
