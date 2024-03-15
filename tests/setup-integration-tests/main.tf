terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.95.0"
    }
  }
}

locals {
  name_suffix = random_id.name_suffix.hex
}

resource "random_id" "name_suffix" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.0"

  workspace_name      = "log-${local.name_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
}
