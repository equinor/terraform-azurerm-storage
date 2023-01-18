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
}

module "vault" {
  source = "github.com/equinor/terraform-azurerm-key-vault?ref=7.2.0"

  vault_name                 = "kv-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  locastion                  = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  purge_protection_enabled = true

  access_policies = [
    {
      key_permissions    = ["get", "create", "delete", "list", "restore", "recover", "unwrapkey", "wrapkey", "purge", "encrypt", "decrypt", "sign", "verify"]
      secret_permissions = ["get"]
    }
  ]
}

resource "azurerm_key_vault_key" "example" {
  name         = "tfex-key"
  key_vault_id = module.vault.vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    module.vault.access_policies
  ]
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.account_id
  key_vault_id       = module.vault.vault_id
  key_name           = module.vault.vault_name
}
