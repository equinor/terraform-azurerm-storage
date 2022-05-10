locals {
  application_alnum = join("", regexall("[a-z0-9]", lower(var.application)))

  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_storage_account" "this" {
  name                = coalesce(var.account_name, "st${local.application_alnum}${var.environment}")
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

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "${azurerm_storage_account.this.name}-logs"
  target_resource_id         = azurerm_storage_account.this.id
  storage_account_id         = azurerm_storage_account.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

resource "azurerm_storage_container" "this" {
  for_each = toset(var.containers)

  name                  = each.value
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"

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
