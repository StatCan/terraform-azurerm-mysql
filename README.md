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

| Name                                     | Type             | Default           | Required | Description                                                                                                               |
| ---------------------------------------- | ---------------- | ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------------- |
| active_directory_administrator_object_id | string           | `""`              | no       | The Active Directory Administrator Object ID.                                                                             |
| active_directory_administrator_tenant_id | string           | `""`              | no       | The Active Directory Administrator Tenant ID.                                                                             |
| administrator_login                      | string           | n/a               | yes      | The Administrator Login for the PostgreSQL Server.                                                                        |
| administrator_login_password             | string           | n/a               | yes      | The Password associated with the administrator_login for the PostgreSQL Server.                                           |
| databases                                | map(map(string)) | n/a               | yes      | The name, collatation, and charset of the PostgreSQL database(s). (defaults: charset="utf8", collation="utf8_unicode_ci") |
| emails                                   | list             | n/a               | yes      | List of email addresses that should recieve the security reports.                                                         |
| ip_rules                                 | list             | n/a               | yes      | List of public IP or IP ranges in CIDR Format.                                                                            |
| firewall_rules                           | list             | n/a               | yes      | Specifies the Start IP Address associated with this Firewall Rule.                                                        |
| key_size                                 | number           | `2048`            | no       | Size of key to create in Key Vault.                                                                                       |
| key_type                                 | string           | `"RSA"`           | no       | Type of key to create in the Key Vault.                                                                                   |
| key_vault_id                             | string           | `""`              | no       | The Key Vault id for the Customer Managed Key.                                                                            |
| kv_db_enable                             | string           | `"false"`         | no       | Enable Key Vault to be used against the MySQL instance.                                                                   |
| kv_db_name                               | string           | `""`              | no       | The Key Vault name to be used against the MySQL instance.                                                                 |
| kv_db_rg                                 | string           | `""`              | no       | The Key Vault resource group to be used against the MySQL instance.                                                       |
| kv_db_tenant_id                          | string           | `""`              | yes      | The Tenant ID to be used for the Key Vault against the MySQL instance.                                                    |
| kv_workflow_enable                       | string           | `"false"`         | no       | Enable Key Vault workflow for storage of passwords and pointer to logging storage account.                                |
| kv_workflow_name                         | string           | `""`              | no       | The Key Vault name.                                                                                                       |
| kv_workflow_rg                           | string           | `""`              | no       | The Key Vault resource group.                                                                                             |
| kv_workflow_salogging_rg                 | string           | n/a               | yes      | The Key Vault storage account for logging resource grou.                                                                  |
| location                                 | string           | `"canadacentral"` | no       | Specifies the supported Azure location where the resource exists.                                                         |
| mysql_version                            | string           | `"8.0"`           | no       | The version of the PostgreSQL Server.                                                                                     |
| name                                     | string           | n/a               | yes      | The name of the PostgreSQL Server.                                                                                        |
| public_network_access_enabled            | string           | `"false"`         | no       | Whether or not public network access is allowed for this server.                                                          |
| resource_group                           | string           | n/a               | yes      | The name of the resource group in which to create the PostgreSQL Server.                                                  |
| sku_name                                 | string           | `"GP_Gen5_4"`     | no       | Specifies the SKU Name for this PostgreSQL Server.                                                                        |
| ssl_enforcement_enabled                  | string           | `"true"`          | no       | Specifies if SSL should be enforced on connections.                                                                       |
| ssl_minimal_tls_version_enforced         | string           | `"TLS1_2"`        | no       | The mimimun TLS version to support on the sever.                                                                          |
| storagesize_mb                           | string           | `"640000"`        | no       | Specifies the version of PostgreSQL to use.                                                                               |
| subnet_ids                               | string           | n/a               | yes      | The IDs of the subnet that the PostgreSQL server will be connected to.                                                    |
| tags                                     | map              | `"<map>"`         | n/a      | A mapping of tags to assign to the resource.                                                                              |
| vnet_enable                              | string           | `"false"`         | no       | Enable Virtual Network logic.                                                                                             |
| vnet_name                                | string           | n/a               | no       | Name for your Virtual Network.                                                                                            |
| subnet_enable                            | string           | `"false"`         | no       | Enable Subnet logic.                                                                                                      |
| subnet_name                              | string           | n/a               | no       | Name for your Subnet.                                                                                                     |

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

| Date     | Release | Change                                                                                     |
| -------- | ------- | ------------------------------------------------------------------------------------------ |
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
