# Server

variable "name" {
  description = "(Required) The name of the MySQL Server"
}

variable "database_names" {
  type        = list(string)
  description = "(Required) The name of the MySQL database(s)"
}

variable "dependencies" {
  type        = list(string)
  description = "(Required) Dependency management of resources"
}

variable "administrator_login" {
  description = "(Required) The Administrator Login for the MySQL Server"
}

variable "administrator_login_password" {
  description = "(Required) The Password associated with the administrator_login for the MySQL Server"
}

variable "sku_name" {
  description = "(Required) Specifies the SKU Name for this MySQL Server"
  default     = "GP_Gen5_4"
}

variable "mysql_version" {
  description = "(Required) The version of the MySQL Server"
  default     = "8.0"
}

variable "storagesize_mb" {
  description = "(Required)  Specifies the version of MySQL to use"
  default     = 640000
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists"
  default     = "canadacentral"
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which to create the MySQL Server"
}

variable "subnet_id" {
  description = "(Required) The ID of the subnet that the MySQL server will be connected to"
}

variable "public_network_access_enabled" {
  description = "(Required) Whether or not public network access is allowed for this server"
  default     = false
}

variable "ssl_enforcement_enabled" {
  description = "(Required) Specifies if SSL should be enforced on connections"
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "(Required) The mimimun TLS version to support on the sever"
  default     = "TLS1_2"
}

variable "key_vault_id" {
  description = "(Required) The Key Vault id for the Customer Managed Key"
  default     = ""
}

variable "active_directory_administrator_object_id" {
  description = "(Required) The Active Directory Administrator Object ID"
  default     = ""
}

variable "active_directory_administrator_tenant_id" {
  description = "(Required) The Active Directory Administrator Tenant ID"
  default     = ""
}

variable "firewall_rules" {
  type        = list(string)
  description = "(Required) Specifies the Start IP Address associated with this Firewall Rule"
}

# Parameters

variable "query_store_capture_interval" {
  description = "(Optional) The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated"
  default     = 15
}

variable "query_store_capture_mode" {
  description = "(Optional) The query store capture mode, NONE means do not capture any statements"
  default     = "ALL"
}

variable "query_store_capture_utility_queries" {
  description = "(Optional) Turning ON or OFF to capture all the utility queries that is executing in the system"
  default     = "YES"
}

variable "query_store_retention_period_in_days" {
  description = "(Optional) The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated"
  default     = 7
}

variable "max_allowed_packet" {
  description = "(Optional) The maximum size of one packet or any generated/intermediate string"
  default     = 536870912
}

variable "innodb_buffer_pool_size" {
  description = "(Optional) The size in bytes of the buffer pool, the memory area where InnoDB caches table and index data"
  default     = 16106127360
}

variable "table_definition_cache" {
  description = "(Optional) The number of table definitions (from .frm files) that can be stored in the definition cache"
  default     = 5000
}

variable "table_open_cache" {
  description = "(Optional) The number of open tables for all threads"
  default     = 5000
}

variable "binlog_expire_logs_seconds" {
  description = "(Optional) The number of seconds for automatic binary log file removal. The default is 0, which means no automatic removal. Possible removals happen at startup and when the binary log is flushed"
  default     = 300
}
