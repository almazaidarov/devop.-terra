# Create a resource group
resource "azurerm_resource_group" "change3" {
  name     = "change3-resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "change3-network" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.change3.name
  location            = azurerm_resource_group.change3.location
  address_space       = ["10.0.0.0/16"]
}