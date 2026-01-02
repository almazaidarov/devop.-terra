# Create a resource group
resource "azurerm_resource_group" "change3" {
  name     = "change3-resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "change3_network" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.change3.name
  location            = azurerm_resource_group.change3.location
  address_space       = ["10.0.0.0/16"]
}



resource "azurerm_subnet" "change3_subnet1" {
  name                 = "change3_subnet1"
  resource_group_name  = azurerm_resource_group.change3.name
  virtual_network_name = azurerm_virtual_network.change3_network.name
  address_prefixes     = ["10.0.1.0/24"]

}


resource "azurerm_subnet" "change3_subnet2" {
  name                 = "change3_subnet2"
  resource_group_name  = azurerm_resource_group.change3.name
  virtual_network_name = azurerm_virtual_network.change3_network.name
  address_prefixes     = ["10.0.2.0/24"]

}


resource "azurerm_subnet" "change3_subnet3" {
  name                 = "change3_subnet3"
  resource_group_name  = azurerm_resource_group.change3.name
  virtual_network_name = azurerm_virtual_network.change3_network.name
  address_prefixes     = ["10.0.3.0/24"]

}