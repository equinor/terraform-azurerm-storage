terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.74.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">= 0.1.0"
    }
  }
}
