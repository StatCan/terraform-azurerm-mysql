# Terraform for Azure Managed Database MySQL

The overall flow for this module is pretty simple:

* Create Azure storage account to store Terraform state
* Create Azure managed database configuration in a modular manner
* Add any extensions you need for the MySQL managed database service

## Security Controls

* None

## Dependencies

* None

## Optional (depending on options configured)

* None

## Usage

```terraform
name                             = var.managed_mysql_name
database_names                   = ["application"]
dependencies                     = []
administrator_login              = "mysqladmin"
administrator_login_password     = var.managed_mysql_password
sku_name                         = "GP_Gen5_4"
mysql_version                    = "5.7"
storagesize_mb                   = 256000
location                         = "canadacentral"
resource_group                   = "XX-XXXX-XXXX-XXX-XXX-RGP"
subnet_id                        = var.managed_mysql_subnet_id
firewall_rules                   = []
public_network_access_enabled    = true
ssl_enforcement_enabled          = true
ssl_minimal_tls_version_enforced = "TLS1_2"
```

## Variables Values

| Name                             | Type   | Required | Value                                                                     |
|----------------------------------|--------|----------|---------------------------------------------------------------------------|
| name                             | string | yes      | The name of the MySQL Server                                              |
| database_names                   | list   | yes      | The name of the MySQL database(s)                                         |
| dependencies                     | list   | yes      | Dependency management of resources                                        |
| administrator_login              | string | yes      | The Administrator Login for the MySQL Server                              |
| administrator_login_password     | string | yes      | The Password associated with the administrator_login for the MySQL Server |
| sku_name                         | string | yes      | Specifies the SKU Name for this MySQL Server                              |
| mysql_version                    | string | yes      | The version of the MySQL Server                                           |
| storagesize_mb                   | string | yes      | Specifies the version of MySQL to use                                     |
| location                         | string | yes      | Specifies the supported Azure location where the resource exists          |
| resource_group                   | string | yes      | The name of the resource group in which to create the MySQL Server        |
| subnet_id                        | string | yes      | The ID of the subnet that the MySQL server will be connected to           |
| firewall_rules                   | list   | yes      | Specifies the Start IP Address associated with this Firewall Rule         |
| public_network_access_enabled    | string | yes      | Whether or not public network access is allowed for this server           |
| ssl_enforcement_enabled          | string | yes      | Specifies if SSL should be enforced on connections                        |
| ssl_minimal_tls_version_enforced | string | yes      | The mimimun TLS version to support on the sever                           |

## History

| Date     | Release    | Change                                     |
|----------|------------|--------------------------------------------|
| 20210207 | 20210207.1 | The v1.0.0 relase of Terraform module      |
