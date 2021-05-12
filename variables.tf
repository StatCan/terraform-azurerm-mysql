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

variable "database_names" {
  type        = list(map(string))
  description = "(Required) The name of the MySQL database(s)."
}

variable "dependencies" {
  type        = list(string)
  description = "(Required) Dependency management of resources."
}

variable "emails" {
  type        = list(string)
  description = "(Required) List of email addresses that should recieve the security reports."
  default     = []
}

variable "firewall_rules" {
  type        = list(string)
  description = "(Required) Specifies the Start IP Address associated with this Firewall Rule."
}

variable "key_vault_id" {
  description = "(Optional) The Key Vault id for the Customer Managed Key."
  default     = ""
}

variable "kv_name" {
  description = "(Optional) The Key Vault name."
  default     = ""
}

variable "kv_rg" {
  description = "(Optional) The Key Vault resource group."
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

variable "subnet_id" {
  description = "(Required) The ID of the subnet that the MySQL server will be connected to."
}

variable "storageaccountinfo_resource_group_name" {
  description = "(Optional) The storageaccountinfo resource group name."
  default     = ""
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

variable "threat_enable" {
  description = "(Optional) Enable Threat Detection Policy."
  default     = false
}

# Parameters

variable "binlog_expire_logs_seconds" {
  description = "(Optional) The number of seconds for automatic binary log file removal. The default is 0, which means no automatic removal. Possible removals happen at startup and when the binary log is flushed."
  default     = 300
}

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
