output "id" {
  value = azurerm_mysql_server.mysql.id
}

output "name" {
  value = azurerm_mysql_server.mysql.name
}

output "fqdn" {
  value = azurerm_mysql_server.mysql.fqdn
}

output "administrator_login" {
  value = "${azurerm_mysql_server.mysql.administrator_login}@${azurerm_mysql_server.mysql.name}"
}

output "identity_tenant_id" {
  value = azurerm_mysql_server.mysql.identity[0].tenant_id
}

output "identity_object_id" {
  value = azurerm_mysql_server.mysql.identity[0].principal_id
}

output "storage_account_id" {
  value = length(azurerm_storage_account.mysql) > 0 ? azurerm_storage_account.mysql[0].id : null
}

output "storage_account_name" {
  value = length(azurerm_storage_account.mysql) > 0 ? azurerm_storage_account.mysql[0].name : null
}
