resource "azurerm_storage_account" "this" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  is_hns_enabled                  = var.is_hns_enabled
  queue_encryption_key_type       = var.queue_encryption_key_type
  table_encryption_key_type       = var.table_encryption_key_type
  allow_nested_items_to_be_public = var.allow_blob_public_access

  tags = var.tags

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? [var.blob_properties] : []

    content {
      versioning_enabled  = blob_properties.value["versioning_enabled"]
      change_feed_enabled = blob_properties.value["change_feed_enabled"]

      delete_retention_policy {
        days = blob_properties.value["delete_retention_policy_days"]
      }

      container_delete_retention_policy {
        days = blob_properties.value["container_delete_retention_policy_days"]
      }

      dynamic "restore_policy" {
        for_each = blob_properties.value["restore_policy_days"] > 0 ? [blob_properties.value["restore_policy_days"]] : []

        content {
          days = restore_policy.value
        }
      }

      dynamic "cors_rule" {
        for_each = blob_properties.value["cors_rules"]

        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = var.share_properties != null ? [var.share_properties] : []

    content {
      retention_policy {
        days = share_properties.value["retention_policy_days"]
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties != null ? [var.queue_properties] : []

    content {
      logging {
        delete                = queue_properties.value["logging_delete"]
        read                  = queue_properties.value["logging_read"]
        write                 = queue_properties.value["logging_write"]
        version               = queue_properties.value["logging_version"]
        retention_policy_days = queue_properties.value["logging_retention_policy_days"]
      }

      hour_metrics {
        enabled               = queue_properties.value["hour_metrics_enabled"]
        include_apis          = queue_properties.value["hour_metrics_include_apis"]
        version               = queue_properties.value["hour_metrics_version"]
        retention_policy_days = queue_properties.value["hour_metrics_retention_policy_days"]
      }

      minute_metrics {
        enabled               = queue_properties.value["minute_metrics_enabled"]
        include_apis          = queue_properties.value["minute_metrics_include_apis"]
        version               = queue_properties.value["minute_metrics_version"]
        retention_policy_days = queue_properties.value["minute_metrics_retention_policy_days"]
      }
    }
  }

  network_rules {
    default_action             = var.firewall_default_action
    bypass                     = var.firewall_bypass
    ip_rules                   = var.firewall_ip_rules
    virtual_network_subnet_ids = var.firewall_virtual_network_subnet_ids
  }
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
