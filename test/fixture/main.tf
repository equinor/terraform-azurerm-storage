terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azapi" {}

locals {
  application = random_id.this.hex
  environment = "test"
}

data "http" "public_ip" {
  url = "https://ifconfig.me"
}

resource "random_id" "this" {
  byte_length = 8
}

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

  firewall_ip_rules = [data.http.public_ip.body]

  containers = ["container", "container1", "container-2"]

  queues = ["queue", "queue1", "queue-2"]

  tables = ["FirstTable", "secondTable", "THIRD"]

  file_shares = ["share", "share1", "share-2"]

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
