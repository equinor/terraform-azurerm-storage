output "account_id" {
  value = azurerm_storage_account.this.id
}

output "account_name" {
  value = azurerm_storage_account.this.name
}

output "blob_endpoint" {
  value = azurerm_storage_account.this.primary_blob_endpoint
}

output "queue_endpoint" {
  value = azurerm_storage_account.this.primary_queue_endpoint
}

output "table_endpoint" {
  value = azurerm_storage_account.this.primary_table_endpoint
}

output "file_endpoint" {
  value = azurerm_storage_account.this.primary_file_endpoint
}

output "primary_access_key" {
  value     = azurerm_storage_account.this.primary_access_key
  sensitive = true
}

output "secondary_access_key" {
  value     = azurerm_storage_account.this.secondary_access_key
  sensitive = true
}

output "primary_connection_string" {
  value     = azurerm_storage_account.this.primary_connection_string
  sensitive = true
}

output "secondary_connection_string" {
  value     = azurerm_storage_account.this.secondary_connection_string
  sensitive = true
}
