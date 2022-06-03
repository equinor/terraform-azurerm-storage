locals {
  suffix       = "${var.application}-${var.environment}"
  suffix_alnum = join("", regexall("[a-z0-9]", lower(local.suffix)))
  tags         = merge({ application = var.application, environment = var.environment }, var.tags)

  # TODO: Write a comment.
  # Ref: https://docs.microsoft.com/en-us/azure/backup/blob-backup-configure-manage#create-a-backup-policy
  blob_pitr_days = 30

  # TODO: Write a coment.
  # Ref: https://docs.microsoft.com/en-us/azure/backup/blob-backup-overview#protection
  blob_delete_days = local.blob_pitr_days + 5
}

resource "azurerm_storage_account" "this" {
  name                = coalesce(var.account_name, "st${local.suffix_alnum}")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type
  access_tier              = var.access_tier

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = var.shared_access_key_enabled

  tags = local.tags

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true

    delete_retention_policy {
      days = local.blob_delete_days
    }

    container_delete_retention_policy {
      days = local.blob_delete_days
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
        enabled = true
        days    = local.blob_pitr_days
      }
    }
  })
}

# Delete previous blob versions to optimize costs.
# Ref: https://docs.microsoft.com/en-us/azure/storage/blobs/lifecycle-management-overview
resource "azurerm_storage_management_policy" "this" {
  storage_account_id = azurerm_storage_account.this.id

  rule {
    name    = "delete-previous-versions"
    enabled = true

    filters {
      blob_types = [
        "blockBlob",
      ]

      prefix_match = []
    }

    actions {
      version {
        delete_after_days_since_creation = local.blob_delete_days
      }
    }
  }
}

resource "azurerm_storage_container" "this" {
  for_each = toset(var.containers)

  name                  = each.value
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
  metadata              = {}
}

resource "azurerm_storage_queue" "this" {
  for_each = toset(var.queues)

  name                 = each.value
  storage_account_name = azurerm_storage_account.this.name
  metadata             = {}
}

resource "azurerm_storage_table" "this" {
  for_each = toset(var.tables)

  name                 = each.value
  storage_account_name = azurerm_storage_account.this.name
}

resource "azurerm_storage_share" "this" {
  for_each = toset(var.file_shares)

  name                 = each.value
  storage_account_name = azurerm_storage_account.this.name
  quota                = 5120
  metadata             = {}
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

resource "azurerm_role_assignment" "account_contributor" {
  for_each = toset(var.account_contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "blob_contributor" {
  for_each = toset(var.blob_contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "blob_reader" {
  for_each = toset(var.blob_readers)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "queue_contributor" {
  for_each = toset(var.queue_contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "queue_reader" {
  for_each = toset(var.queue_readers)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Queue Data Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "table_contributor" {
  for_each = toset(var.table_contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "table_reader" {
  for_each = toset(var.table_readers)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Table Data Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "file_contributor" {
  for_each = toset(var.file_contributors)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "file_reader" {
  for_each = toset(var.file_readers)

  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage File Data SMB Share Reader"
  principal_id         = each.value
}
