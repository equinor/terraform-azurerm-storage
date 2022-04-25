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

resource "azurerm_user_assigned_identity" "this" {
  name                = coalesce(var.user_assigned_identity_name, "id-st-user-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = local.tags
}

resource "azurerm_role_assignment" "storage_account_contributor" {
  for_each = toset(var.storage_account_contributor)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  for_each = toset(var.blob_data_contributor)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_blob_data_reader" {
  for_each = toset(var.blob_data_reader)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_queue_data_contributor" {
  for_each = toset(var.queue_data_contributor)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_queue_data_reader" {
  for_each = toset(var.queue_data_reader)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Queue Data Reader"
  principal_id         = each.value
}


resource "azurerm_role_assignment" "storage_table_data_contributor" {
  for_each = toset(var.table_data_contributor)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Table Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_table_data_reader" {
  for_each = toset(var.table_data_reader)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage Table Data Reader"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_file_data_smb_share_contributor" {
  for_each = toset(var.smb_share_contributor)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "storage_file_data_smb_share_reader" {
  for_each = toset(var.smb_share_reader)

  scope                = azurerm_user_assigned_identity.this.id
  role_definition_name = "Storage File Data SMB Share Reader"
  principal_id         = each.value
}
