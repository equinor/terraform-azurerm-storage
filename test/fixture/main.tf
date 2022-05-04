provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"

  object_ids = var.test_role_assignments ? [data.azurerm_client_config.current.object_id] : []
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

  account_contributors = local.object_ids
  blob_contributors    = local.object_ids
  blob_readers         = local.object_ids
  queue_contributors   = local.object_ids
  queue_readers        = local.object_ids
  table_contributors   = local.object_ids
  table_readers        = local.object_ids
  file_contributors    = local.object_ids
  file_readers         = local.object_ids
}
