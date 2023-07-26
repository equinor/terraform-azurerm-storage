locals {
  is_premium_block_blob_storage = var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage"
  is_premium_data_lake_storage  = var.account_tier == "Premium" && var.account_kind == "BlockBlobStorage" && var.is_hns_enabled
  is_premium_file_storage       = var.account_tier == "Premium" && var.account_kind == "FileStorage"
  is_premium_gpv2_storage       = var.account_tier == "Premium" && var.account_kind == "StorageV2"
  is_standard_blob_storage      = var.account_tier == "Standard" && var.account_kind == "BlobStorage"
  is_standard_data_lake_storage = var.account_tier == "Standard" && var.account_kind == "StorageV2" && var.is_hns_enabled
  # No need to check for "is_standard_gpv2_storage", since that is what this module is configured for by default.

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))
}

resource "azurerm_storage_account" "this" {
  name                = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only        = true
  min_tls_version                  = "TLS1_2"
  shared_access_key_enabled        = var.shared_access_key_enabled
  is_hns_enabled                   = var.is_hns_enabled
  queue_encryption_key_type        = var.queue_encryption_key_type
  table_encryption_key_type        = var.table_encryption_key_type
  allow_nested_items_to_be_public  = var.allow_blob_public_access
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  tags = var.tags

  # Configure blob properties if supported.
  dynamic "blob_properties" {
    for_each = !local.is_premium_file_storage ? [0] : []

    content {
      # Configure versioning if supported.
      versioning_enabled = (!local.is_premium_data_lake_storage && !local.is_premium_gpv2_storage && !local.is_standard_data_lake_storage) ? var.blob_versioning_enabled : false

      # Configure change feed if supported.
      change_feed_enabled = (!local.is_premium_data_lake_storage && !local.is_premium_gpv2_storage && !local.is_standard_data_lake_storage) ? var.blob_change_feed_enabled : false

      delete_retention_policy {
        days = var.blob_delete_retention_policy_days
      }

      container_delete_retention_policy {
        days = var.blob_container_delete_retention_policy
      }

      # Configure restore policy if enabled and supported.
      dynamic "restore_policy" {
        for_each = (var.blob_restore_policy_days > 0 && !local.is_premium_block_blob_storage && !local.is_premium_data_lake_storage && !local.is_premium_gpv2_storage && !local.is_standard_blob_storage && !local.is_standard_data_lake_storage) ? [0] : []

        content {
          days = var.blob_restore_policy_days
        }
      }

      dynamic "cors_rule" {
        for_each = var.blob_cors_rules

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
    # Check if share properties is enabled and supported.
    for_each = (!local.is_premium_block_blob_storage && !local.is_premium_data_lake_storage && !local.is_premium_gpv2_storage && !local.is_standard_blob_storage && !local.is_standard_data_lake_storage) ? [0] : []

    content {
      retention_policy {
        days = var.share_retention_policy_days
      }
    }
  }

  dynamic "queue_properties" {
    # Check if queue properties is enabled and supported.
    for_each = (
      var.queue_properties != null
      && !local.is_premium_block_blob_storage
      && !local.is_premium_data_lake_storage
      && !local.is_premium_file_storage
      && !local.is_premium_gpv2_storage
      && !local.is_standard_blob_storage
    ) ? [var.queue_properties] : []

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

  dynamic "identity" {
    for_each = local.identity_type != "" ? [0] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = var.network_rules_bypass
    ip_rules                   = var.network_rules_ip_rules
    virtual_network_subnet_ids = var.network_rules_virtual_network_subnet_ids
  }

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? [var.custom_domain] : []
    content {
      name          = custom_domain.value["name"]
      use_subdomain = custom_domain.value["use_subdomain"]
    }
  }
}

resource "azurerm_advanced_threat_protection" "this" {
  target_resource_id = azurerm_storage_account.this.id
  enabled            = true
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = toset(["blob", "queue", "table", "file"])

  name                       = "audit-logs"
  target_resource_id         = "${azurerm_storage_account.this.id}/${each.value}Services/default"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Ref: https://registry.terraform.io/providers/hashicorp/azurerm/3.65.0/docs/resources/monitor_diagnostic_setting#log_analytics_destination_type
  log_analytics_destination_type = null

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
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
