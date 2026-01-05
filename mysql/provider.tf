terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "5f693d88-2d46-4814-b35e-672e4a203a71"
}
