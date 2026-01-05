resource "azurerm_resource_group" "example" {
  name     = "database-rg"
  location = "East US"
}

resource "azurerm_mssql_server" "example" {
  name                         = "example-sql-server-12345"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"

  administrator_login          = "sqladminuser"
  administrator_login_password = "StrongPassword123!"

  minimum_tls_version = "1.2"
}
