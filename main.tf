locals {
  application_alnum = join("", regexall("[a-z0-9]", lower(var.application)))

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_storage_account" "this" {
  name                = coalesce(var.storage_account_name, "st${local.application_alnum}${var.environment}")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = var.shared_access_key_enabled

  tags = local.tags

  blob_properties {
    versioning_enabled  = var.blob_versioning_enabled
    change_feed_enabled = var.blob_change_feed_enabled

    delete_retention_policy {
      days = var.blob_delete_retention_policy
    }

    container_delete_retention_policy {
      days = var.blob_delete_retention_policy
    }
  }

  network_rules {
    default_action = length(var.network_ip_rules) == 0 ? "Allow" : "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.network_ip_rules
  }
}
