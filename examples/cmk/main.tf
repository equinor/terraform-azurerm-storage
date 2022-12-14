provider "azurerm" {
  # ! Use Azure AD to connect to Storage
  storage_use_azuread = true

  features {}
}

locals {
  tags = {
    environment = "test"
  }
}

data "azurerm_client_config" "current" {}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location

  tags = local.tags
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.1.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  tags = local.tags
}

module "key_vault" {
  source = "github.com/equinor/terraform-azurerm-key-vault?ref=v6.1.0"

  vault_name                 = "kv-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  purge_protection_enabled = true

  # access_policies = [
  #   {
  #     object_id          = data.azurerm_client_config.current.object_id
  #     secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
  #     key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  #   }
  # ]

  # firewall_ip_rules = [
  #   "1.1.1.1/32",
  #   "2.2.2.2/32",
  #   "3.3.3.3/32"
  # ]

  tags = local.tags
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = module.key_vault.vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
}

resource "azurerm_key_vault_key" "example" {
  name         = "example-key-${random_id.this.hex}"
  key_vault_id = module.key_vault.vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client
  ]
}

module "storage" {
  # source = "github.com/equinor/terraform-azurerm-storage"
  source = "../.."

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  shared_access_key_enabled = true

  # firewall_ip_rules = [
  #   "1.1.1.1",
  #   "2.2.2.2",
  #   "3.3.3.3"
  # ]

  tags = local.tags
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.account_id
  key_vault_id       = module.key_vault.vault_id
  key_name           = azurerm_key_vault_key.example.name
}

