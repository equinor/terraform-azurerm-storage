output "account_id" {
  description = "The ID of this Storage account."
  value       = azurerm_storage_account.this.id
}

output "account_name" {
  description = "The name of this Storage account."
  value       = azurerm_storage_account.this.name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Storage account."
  value       = try(azurerm_storage_account.this.identity[0].principal_id, null)
}

output "account_tier" {
  description = "The performance tier of this Storage account."
  value       = azurerm_storage_account.this.account_tier
}

output "account_kind" {
  description = "The kind of this Storage account."
  value       = azurerm_storage_account.this.account_kind
}

output "account_replication_type" {
  description = "The replication type of this Storage account."
  value       = azurerm_storage_account.this.account_replication_type
}

output "blob_endpoint" {
  description = "The endpoint URL for this Blob Storage."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The secondary endpoint URL for this Blob Storage."
  value       = azurerm_storage_account.this.secondary_blob_endpoint
}

output "queue_endpoint" {
  description = "The endpoint URL for this Queue Storage."
  value       = azurerm_storage_account.this.primary_queue_endpoint
}

output "secondary_queue_endpoint" {
  description = "The secondary endpoint URL for this Queue Storage."
  value       = azurerm_storage_account.this.secondary_queue_endpoint
}

output "table_endpoint" {
  description = "The endpoint URL for this Table Storage."
  value       = azurerm_storage_account.this.primary_table_endpoint
}

output "secondary_table_endpoint" {
  description = "The secondary endpoint URL for this Table Storage."
  value       = azurerm_storage_account.this.secondary_table_endpoint
}

output "file_endpoint" {
  description = "The endpoint URL for this File Storage."
  value       = azurerm_storage_account.this.primary_file_endpoint
}

output "secondary_file_endpoint" {
  description = "The secondary endpoint URL for this File Storage."
  value       = azurerm_storage_account.this.secondary_file_endpoint
}

output "dfs_endpoint" {
  description = "The endpoint URL for this Data Lake Storage."
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}

output "secondary_dfs_endpoint" {
  description = "The secondary endpoint URL for this Data Lake Storage."
  value       = azurerm_storage_account.this.secondary_dfs_endpoint
}

output "primary_access_key" {
  description = "The primary access key for this Storage account."
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for this Storage account."
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string for this Storage account."
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string for this Storage account."
  value       = azurerm_storage_account.this.secondary_connection_string
  sensitive   = true
}

output "is_hns_enabled" {
  description = "Is Data Lake Storage Gen2 hierarchical namespace (HNS) enabled for this Storage account?"
  value       = azurerm_storage_account.this.is_hns_enabled
}
