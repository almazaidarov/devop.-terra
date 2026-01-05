locals {
  first_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiePcuF7TP7JoptFbSV+EpdeS7Ujkp6RsU2o0BDq/agQ7ODXCL8BUUL4lOinQXq+NHwYNrWcgr7e+7p0bGYya0WaV0BiraZm0bczNfSC3PyawjlakqJXWHQPq7H8TLA5vfxqcsb51NHqwMS8+xrkqILPvTXb9ejC3ESjZy6N6a+KHRg/8ZcrMeyBx6bA/qSSglbR9a8jROVsn3+mucwyhSsgabD2idESf5FYzbAvBEIFjglTx4RHrA0BT6Cp1HHKTZet5iOfW8RkXZtXWmwrNJ24sLusf1zHqdx39K2wwJwSEaHoeXeW+UxcKYBVzgkULnKu7tjIUI8G4AhtRajTcoShvoyYQBmohu32a6TZx1L5vYG8ATIvjII3XSCBLrZue1qAbK2s5f3Ecoh5x/oakioR6W39VUMhQ3dsE6fz15bp+7fdzpjQBcf45XMnsZFpInu4bI1xoTdOUdIXyOMZDwjOyBNi9gaJOgJ/suVU/y7hOiKrXO6IWXG0bmPnig780= almazaidarov@Almazs-MacBook-Pro.local"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/almaz/.ssh/id_ed25519.pub")


  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
}