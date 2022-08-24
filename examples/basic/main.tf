terraform {
  required_providers {
    # ! Download the AzAPI provider by Azure
    azapi = {
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  # ! Use Azure AD to connect to Storage
  storage_use_azuread = true

  features {}
}

locals {
  tags = {
    environment = "test"
  }
}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location

  tags = local.tags
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.0.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  tags = local.tags
}

module "storage" {
  # source = "github.com/equinor/terraform-azurerm-storage"
  source = "../.."

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  firewall_ip_rules = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3"
  ]

  tags = local.tags
}
