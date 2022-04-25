output "user_assigned_identity_name" {
  description = "The name of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "user_assigned_identity_principal_id" {
  description = "Client ID associated with the user assigned identity."
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "user_assigned_identity_client_id" {
  description = "Client ID associated with the user assigned identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "user_assigned_identity_tenant_id" {
  description = "Tenant ID associated with the user assigned identity."
  value       = azurerm_user_assigned_identity.this.tenant_id
}
