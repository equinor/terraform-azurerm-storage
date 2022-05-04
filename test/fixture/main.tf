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

module "storage" {
  source = "../.."

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  account_contributor   = [data.azurerm_client_config.current.object_id]
  blob_contributor      = [data.azurerm_client_config.current.object_id]
  blob_reader           = [data.azurerm_client_config.current.object_id]
  queue_contributor     = [data.azurerm_client_config.current.object_id]
  queue_reader          = [data.azurerm_client_config.current.object_id]
  table_contributor     = [data.azurerm_client_config.current.object_id]
  table_reader          = [data.azurerm_client_config.current.object_id]
  smb_share_contributor = [data.azurerm_client_config.current.object_id]
  smb_share_reader      = [data.azurerm_client_config.current.object_id]

  role_list = var.role_list
}
