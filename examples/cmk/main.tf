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

# resource "azurerm_user_assigned_identity" "example" {
#   location            = var.location
#   name                = "uai-${random_id.this.hex}"
#   resource_group_name = azurerm_resource_group.this.name
# }

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

  account_tier             = "Premium"
  account_replication_type = "LRS"

  identity = {
    type = "SystemAssigned"
  }

  blob_properties = {
    change_feed_enabled = false
    versioning_enabled  = false
    restore_policy_days = 0
  }

  share_properties = null
  queue_properties = null
}

module "vault" {
  source = "github.com/equinor/terraform-azurerm-key-vault?ref=v8.1.0"

  vault_name                 = "kv-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  purge_protection_enabled = true

  network_acls_ip_rules = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3",
    "8.29.230.8",
    "213.236.148.45"
  ]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = module.vault.vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "example" {
  name            = "example-key"
  key_vault_id    = module.vault.vault_id
  key_type        = "RSA"
  key_size        = 2048
  key_opts        = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  expiration_date = "2024-03-23T20:00:00Z"

  depends_on = [
    azurerm_key_vault_access_policy.client
  ]
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.account_id
  key_vault_id       = module.vault.vault_id
  key_name           = azurerm_key_vault_key.example.name
}
