terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">= 0.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.5.0"
    }
  }
}
