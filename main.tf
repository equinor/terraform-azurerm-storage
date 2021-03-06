resource "azurerm_storage_account" "this" {
  name                = coalesce(var.account_name, replace(lower("st${var.application}${var.environment}"), "/[^a-z0-9]+/", ""))
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access

  tags = merge({ application = var.application, environment = var.environment }, var.tags)

  blob_properties {
    versioning_enabled  = var.blob_versioning_enabled
    change_feed_enabled = var.blob_change_feed_enabled

    delete_retention_policy {
      days = var.blob_delete_retention_days
    }

    container_delete_retention_policy {
      days = var.blob_delete_retention_days
    }
  }

  share_properties {
    retention_policy {
      days = var.file_retention_policy
    }
  }

  network_rules {
    default_action = length(var.firewall_ip_rules) == 0 ? "Allow" : "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.firewall_ip_rules
  }
}

# Enable point-in-time restore (PITR) for this Blob Storage.
# This feature is not yet supported by the AzureRM provider.
resource "azapi_update_resource" "this" {
  type      = "Microsoft.Storage/storageAccounts/blobServices@2021-09-01"
  parent_id = azurerm_storage_account.this.id
  name      = "default"

  body = jsonencode({
    properties = {
      restorePolicy = {
        enabled = var.blob_pitr_enabled
        days    = var.blob_pitr_days
      }
    }
  })
}

resource "azurerm_advanced_threat_protection" "this" {
  target_resource_id = azurerm_storage_account.this.id
  enabled            = var.threat_protection_enabled
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = toset(["blob", "queue", "table", "file"])

  name                       = "${azurerm_storage_account.this.name}-${each.value}-logs"
  target_resource_id         = "${azurerm_storage_account.this.id}/${each.value}Services/default"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "StorageRead"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  log {
    category = "StorageWrite"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  log {
    category = "StorageDelete"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "Capacity"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "Transaction"
    enabled  = false

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
