provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"
}

resource "random_id" "this" {
  byte_length = 8
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.application}-${local.environment}"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${local.application}-${local.environment}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Free"
}

module "storage" {
  source = "../.."

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  account_contributors = [data.azurerm_client_config.current.object_id]
  blob_contributors    = [data.azurerm_client_config.current.object_id]
  blob_readers         = [data.azurerm_client_config.current.object_id]
  queue_contributors   = [data.azurerm_client_config.current.object_id]
  queue_readers        = [data.azurerm_client_config.current.object_id]
  table_contributors   = [data.azurerm_client_config.current.object_id]
  table_readers        = [data.azurerm_client_config.current.object_id]
  file_contributors    = [data.azurerm_client_config.current.object_id]
  file_readers         = [data.azurerm_client_config.current.object_id]
}
