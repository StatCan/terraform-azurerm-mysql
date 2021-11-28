# Terraform for Azure Managed Database MySQL

Creates a MySQL instance using the Azure Managed Database for MySQL service.

## Security Controls

- Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## Dependencies

- Terraform v0.14.x +
- Terraform AzureRM Provider 2.5 +

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Variables

| Name                                     | Type             | Default           | Required | Description                                                                                                              |
| ---------------------------------------- | ---------------- | ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------------ |
| active_directory_administrator_object_id | string           | `""`              | no       | The Active Directory Administrator Object ID.                                                                            |
| active_directory_administrator_tenant_id | string           | `""`              | no       | The Active Directory Administrator Tenant ID.                                                                            |
| administrator_login                      | string           | n/a               | yes      | The Administrator Login for the MySQL Server.                                                                            |
| administrator_login_password             | string           | n/a               | yes      | The Password associated with the administrator_login for the MySQL Server.                                               |
| databases                                | map(map(string)) | n/a               | yes      | The name, collation, and character set of the MySQL database(s). (defaults: charset='utf8', collation='utf8_unicode_ci') |
| diagnostics                              | object()         | null              | no       | Diagnostic settings for those resources that support it.                                                                 |
| emails                                   | list             | n/a               | yes      | List of email addresses that should recieve the security reports.                                                        |
| ip_rules                                 | list             | n/a               | yes      | List of public IP or IP ranges in CIDR Format.                                                                           |
| firewall_rules                           | list             | n/a               | yes      | Specifies the Start IP Address associated with this Firewall Rule.                                                       |
| location                                 | string           | `"canadacentral"` | no       | Specifies the supported Azure location where the resource exists.                                                        |
| name                                     | string           | n/a               | yes      | The name of the MySQL Server.                                                                                            |
| mysql_version                            | string           | `"8.0"`           | no       | The version of the MySQL Server.                                                                                         |
| public_network_access_enabled            | string           | `"false"`         | no       | Whether or not public network access is allowed for this server.                                                         |
| resource_group                           | string           | n/a               | yes      | The name of the resource group in which to create the MySQL Server.                                                      |
| retention_days                           | number           | `90`              | yes      | Specifies the retention in days for logs for this MySQL Server.                                                          |
| sku_name                                 | string           | `"GP_Gen5_4"`     | no       | Specifies the SKU Name for this MySQL Server.                                                                            |
| ssl_enforcement_enabled                  | string           | `"true"`          | no       | Specifies if SSL should be enforced on connections.                                                                      |
| ssl_minimal_tls_version_enforced         | string           | `"TLS1_2"`        | no       | The mimimun TLS version to support on the sever.                                                                         |
| storagesize_mb                           | string           | `"640000"`        | no       | Specifies the version of MySQL to use.                                                                                   |
| subnet_ids                               | list             | n/a               | yes      | The IDs of the subnets that the MySQL server will be connected to.                                                       |
| tags                                     | map              | `"<map>"`         | no       | A mapping of tags to assign to the resource.                                                                             |

## Variables (Advanced)

| Name                         | Type   | Default             | Required | Description                                                                                                       |
| ---------------------------- | ------ | ------------------- | -------- | ----------------------------------------------------------------------------------------------------------------- |
| kv_db_create                 | string | null                | no       | Flag kv_db_create can either be `null` (default), `true` (create key vault), or `false` (use existing key vault). |
| kv_db_name                   | string | null                | no       | The key vault name to be used when kv_db_create is either set to `true` or `false`.                               |
| kv_db_rg                     | string | null                | no       | The key vault resource group to be used when kv_db_create is either set to `true` or `false`."                    |
| kv_db_tenant_id              | string | null                | no       | The key vault tenant id to be used when kv_db_create is either set to `true` or `false`.                          |
| kv_db_key_size               | number | `2048`              | no       | The key vault size to be used when kv_db_create is either set to `true` or `false`.                               |
| kv_db_key_type               | string | `"RSA"`             | no       | The key vault type to be used when kv_db_create is either set to `true` or `false`.                               |
| kv_pointer_enable            | string | `"false"`           | no       | Flag kv_pointer_enable can either be `true` (state from key vault), or `false` (state from terraform).            |
| kv_pointer_name              | string | null                | no       | The key vault name to be used when kv_pointer_enable is set to `true`.                                            |
| kv_workflow_rg               | string | null                | no       | The key vault resource group to be used when kv_pointer_enable is set to `true`.                                  |
| kv_pointer_logging_name      | string | null                | no       | The logging name to be looked up in key vault when kv_pointer_enable is set to `true`.                            |
| kv_pointer_logging_rg        | string | null                | no       | The logging resource group name to be used when kv_pointer_enable is set to `true`.                               |
| kv_pointer_sqladmin_password | string | null                | no       | The sqladmin password to be looked up in key vault when kv_pointer_enable is set to `true`."                      |
| vnet_create                  | string | null                | no       | Flag vnet_create can either be `null` (default), `true` (create vnet), or `false` (use existing vnet).            |
| vnet_cidr                    | string | `172.15.0.0/16`     | no       | Virtual Network CIDR.                                                                                             |
| vnet_name                    | string | null                | no       | The vnet name to be used when vnet_create is either set to `true` or `false`.                                     |
| vnet_rg                      | string | null                | no       | The vnet resource group to be used when vnet_create is either set to `true` or `false`.                           |
| subnet_name                  | string | null                | no       | The subnet name to be used when vnet_create is either set to `true` or `false`.                                   |
| subnet_address_prefixes      | list   | `["172.15.8.0/22"]` | no       | Virtual Network Address Prefixes.                                                                                 |

## Variables (MySQL Configuration)

| Name                                 | Type   | Default         | Required | Description                                                                                                            |
| ------------------------------------ | ------ | --------------- | -------- | ---------------------------------------------------------------------------------------------------------------------- |
| innodb_buffer_pool_size              | int    | `"16106127360"` | no       | The size in bytes of the buffer pool, the memory area where InnoDB caches table and index data.                        |
| max_allowed_packet                   | int    | `"536870912"`   | no       | The maximum size of one packet or any generated/intermediate string.                                                   |
| query_store_capture_interval         | int    | `"15"`          | no       | The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated. |
| query_store_capture_mode             | string | `"All"`         | no       | The query store capture mode, NONE means do not capture any statements.                                                |
| query_store_capture_utility_queries  | string | `"Yes"`         | no       | Turning ON or OFF to capture all the utility queries that is executing in the system.                                  |
| query_store_retention_period_in_days | int    | `"7"`           | no       | The query store capture interval in minutes. Allows to specify the interval in which the query metrics are aggregated. |
| table_definition_cache               | int    | `"5000"`        | no       | The number of table definitions (from .frm files) that can be stored in the definition cache.                          |
| table_open_cache                     | int    | `"5000"`        | no       | The number of open tables for all threads.                                                                             |

## History

| Date     | Release | Change                                                                                     |
| -------- | ------- | ------------------------------------------------------------------------------------------ |
| 20211128 | v4.0.0  | Final refactor with sane defaults and optional advanced logic                              |
| 20211004 | v3.0.0  | Release makes clear some of the more advanced logic                                        |
| 20210907 | v2.2.0  | Release moves the key vault into the module                                                |
| 20210905 | v2.1.2  | Release adds ability to opt out of diagnostics                                             |
| 20210902 | v2.1.1  | Release adds an ip_rules variable                                                          |
| 20210831 | v2.1.0  | Release updates kv workflow, naming, and examples                                          |
| 20210702 | v2.0.0  | Release prevents destruction of databases when one or more are added/removed from the list |
| 20210625 | v1.1.1  | Release which passes tags to other resources and fixes subnet rule names                   |
| 20210623 | v1.1.0  | Release which adds less destructive changes to firewall and subnet rules                   |
| 20210511 | v1.0.2  | Release which adds optional support for ATP                                                |
| 20210211 | v1.0.1  | Release which adds minor documentation improvements                                        |
| 20210207 | v1.0.0  | Release of Terraform module                                                                |
