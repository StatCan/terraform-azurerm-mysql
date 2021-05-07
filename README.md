# Terraform for Azure Managed Database MySQL

Creates a MySQL instance using the Azure Managed Database for MySQL service.

## Security Controls

* Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## Dependencies

* Terraform AzureRM Provider 2.5 +

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Variables

| Name                                     | Type   | Default           | Required | Description                                                                                                           |
|------------------------------------------|--------|-------------------|----------|-----------------------------------------------------------------------------------------------------------------------|
| name                                     | string | n/a               | yes      | The name of the MySQL Server                                                                                          |
| database_names                           | list   | n/a               | yes      | The name of the MySQL database(s)                                                                                     |
| dependencies                             | list   | n/a               | yes      | Dependency management of resources                                                                                    |
| administrator_login                      | string | n/a               | yes      | The Administrator Login for the MySQL Server                                                                          |
| administrator_login_password             | string | n/a               | yes      | The Password associated with the administrator_login for the MySQL Server                                             |
| sku_name                                 | string | `"GP_Gen5_4"`     | no       | Specifies the SKU Name for this MySQL Server                                                                          |
| mysql_version                            | string | `"8.0"`           | no       | The version of the MySQL Server                                                                                       |
| storagesize_mb                           | int    | `"640000"`        | no       | Specifies the version of MySQL to use                                                                                 |
| location                                 | string | `"canadacentral"` | no       | Specifies the supported Azure location where the resource exists                                                      |
| resource_group                           | string | n/a               | yes      | The name of the resource group in which to create the MySQL Server                                                    |
| subnet_id                                | string | n/a               | yes      | The ID of the subnet that the MySQL server will be connected to                                                       |
| public_network_access_enabled            | string | `"false"`         | yes      | Whether or not public network access is allowed for this server                                                       |
| ssl_enforcement_enabled                  | string | `"true"`          | yes      | Specifies if SSL should be enforced on connections                                                                    |
| ssl_minimal_tls_version_enforced         | string | `"TLS1_2"`        | no       | The mimimum TLS version to support on the sever                                                                       |
| key_vault_id                             | string | n/a               | yes      | The Key Vault id for the Customer Managed Key                                                                         |
| active_directory_administrator_object_id | string | n/a               | yes      | The Active Directory Administrator Object ID                                                                          |
| active_directory_administrator_tenant_id | string | n/a               | yes      | The Active Directory Administrator Tenant ID                                                                          |
| firewall_rules                           | list   | n/a               | yes      | Specifies the Start IP Address associated with this Firewall Rule                                                     |
| query_store_capture_interval             | int    | `"15"`            | no       | The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated |
| query_store_capture_mode                 | string | `"All"`           | no       | The query store capture mode, NONE means do not capture any statements                                                |
| query_store_capture_utility_queries      | string | `"Yes"`           | no       | Turning ON or OFF to capture all the utility queries that is executing in the system                                  |
| query_store_retention_period_in_days     | int    | `"7"`             | no       | The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated |
| max_allowed_packet                       | int    | `"536870912"`     | no       | The maximum size of one packet or any generated/intermediate string                                                   |
| innodb_buffer_pool_size                  | int    | `"16106127360"`   | no       | The size in bytes of the buffer pool, the memory area where InnoDB caches table and index data                        |
| table_definition_cache                   | int    | `"5000"`          | no       | The number of table definitions (from .frm files) that can be stored in the definition cache                          |
| table_open_cache                         | int    | `"5000"`          | no       | The number of open tables for all threads                                                                             |
| binlog_expire_logs_seconds               | int    | `"300"`           | no       | The number of seconds for automatic binary log file removal                                                           |

## History

| Date     | Release    | Change                                     |
|----------|------------|--------------------------------------------|
| 20210507 | 20210507.1 | The v1.0.2 relase of Terraform module      |
| 20210211 | 20210211.1 | The v1.0.1 relase of Terraform module      |
| 20210207 | 20210207.1 | The v1.0.0 relase of Terraform module      |
