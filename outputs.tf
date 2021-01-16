output "id" {
  value = azurerm_mysql_server.mysql.id
}

output "name" {
  value = azurerm_mysql_server.mysql.name
}

output "administrator_login" {
  value = azurerm_mysql_server.mysql.administrator_login
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
output "depended_on" {
  value = "${null_resource.dependency_setter.id}-${timestamp()}"
}
