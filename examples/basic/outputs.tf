output "storage_account_name" {
  description = "The name of this storage account."
  value       = module.storage.account_name
}

output "resource_group_name" {
  description = "The name of this resource group."
  value       = azurerm_resource_group.this.name
}

output "subscription_id" {
  description = "The ID of the current subscription."
  value       = data.azurerm_client_config.current.subscription_id
}
