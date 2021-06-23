output "id" {
  value = azurerm_mysql_server.mysql.id
}

output "name" {
  value = azurerm_mysql_server.mysql.name
}

output "administrator_login" {
  value = azurerm_mysql_server.mysql.administrator_login
}

output "fqdn" {
  value = azurerm_mysql_server.mysql.fqdn
}

output "identity_tenant_id" {
  value = azurerm_mysql_server.mysql.identity[0].tenant_id
}

output "identity_object_id" {
  value = azurerm_mysql_server.mysql.identity[0].principal_id
}
