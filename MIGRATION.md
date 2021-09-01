## v1.1.x to v2.0.x

Run the following commands:

```sh
terraform state rm 'module.mysql_example.azurerm_mysql_database.mysql'

terraform import  'module.mysql_example.azurerm_mysql_database.mysql["mysqlservername1"]' '/subscriptions/SUBSCRIPTION_UUID/resourceGroups/mysql-dev-rg/providers/Microsoft.DBforMySQL/servers/mysqlservername/databases/mysqlservername1'
...
terraform import  'module.mysql_example.azurerm_mysql_database.mysql["mysqlservername4"]' '/subscriptions/SUBSCRIPTION_UUID/resourceGroups/mysql-dev-rg/providers/Microsoft.DBforMySQL/servers/mysqlservername/databases/mysqlservername4'
```

> Note: These are just values based on the [examples/](examples/) folder.
