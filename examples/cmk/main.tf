provider "azurerm" {
  storage_use_azuread = true

  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.2.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "storage" {
  # source = "github.com/equinor/terraform-azurerm-storage"
  source = "../.."

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
  shared_access_key_enabled  = true
  identity = {
    type = "SystemAssigned"
  }
}

module "vault" {
  source = "github.com/equinor/terraform-azurerm-key-vault?ref=v7.2.0"

  vault_name                 = "kv-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  purge_protection_enabled = true

  access_policies = [
    {
      object_id          = "25d23649-cc47-49fa-bfd8-12acafc353a2"
      key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
      secret_permissions = ["Get", "Delete", "List", "Restore", "Recover", "Set"]
    }
  ]

  network_acls_ip_rules = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3",
    "8.29.230.8"
  ]
}

resource "azurerm_key_vault_key" "example" {
  name         = "example-key"
  key_vault_id = module.vault.vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    module.vault
  ]
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.account_id
  key_vault_id       = module.vault.vault_id
  key_name           = azurerm_key_vault_key.example.name
}
