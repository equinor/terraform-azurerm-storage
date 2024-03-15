terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

resource "random_id" "name_suffix" {
  byte_length = 8
}

resource "random_uuid" "subscription_id" {}

locals {
  name_suffix         = random_id.name_suffix.hex
  resource_group_name = "rg-${local.name_suffix}"
}
