provider "azurerm" {
  storage_use_azuread = true

  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${random_id.this.hex}"
  location = "northeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

module "storage" {
  source = "../.."

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  account_kind   = var.account_kind
  account_tier   = var.account_tier
  is_hns_enabled = var.is_hns_enabled
}
