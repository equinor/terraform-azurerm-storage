variable "account_id" {
  value = azurerm_storage_account.this.id
}

variable "account_name" {
  value = azurerm_storage_account.this.name
}
