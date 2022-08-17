terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  storage_use_azuread = true

  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.application}-${var.environment}"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${var.application}-${var.environment}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "storage" {
  source = "../.."

  application                = var.application
  environment                = var.environment
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  firewall_ip_rules = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3"
  ]
}

# Give current client access to blob storage
resource "azurerm_role_assignment" "this" {
  scope                = module.storage.account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Example of Object Replication

resource "azurerm_resource_group" "src" {
  name     = "rg-src-${var.application}-${var.environment}"
  location = var.location
}

resource "azurerm_storage_account" "src" {
  name                = "st${var.application}${var.environment}"
  resource_group_name = azurerm_resource_group.src.name
  location            = azurerm_resource_group.src.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }


}

resource "azurerm_storage_container" "src" {
  name                  = "ci${var.application}${var.environment}"
  storage_account_name  = azurerm_storage_account.src.name
  container_access_type = "private"
}

resource "azurerm_resource_group" "dst" {
  name     = "rg-dst-${var.application}${var.environment}"
  location = var.location
}

resource "azurerm_storage_account" "dst" {
  name                = "st${var.application}${var.environment}"
  resource_group_name = azurerm_resource_group.dst.name
  location            = azurerm_resource_group.dst.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }
}

resource "azurerm_storage_container" "dst" {
  name                  = "ci${var.application}${var.environment}"
  storage_account_name  = azurerm_storage_account.dst.name
  container_access_type = "private"
}

resource "azurerm_storage_object_replication" "example" {
  source_storage_account_id      = azurerm_storage_account.src.id
  destination_storage_account_id = azurerm_storage_account.dst.id

  rules {
    source_container_name      = azurerm_storage_account.src.name
    destination_container_name = azurerm_storage_container.dst.name
  }
}

