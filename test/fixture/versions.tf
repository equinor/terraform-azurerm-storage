terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~> 0.1.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.0"
    }
  }
}
