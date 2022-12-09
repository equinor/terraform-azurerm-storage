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

  access_policies = [
    {
      object_id          = data.azurerm_client_config.current.object_id
      secret_permissions = ["Get", "List", "Set", "Delete", "Backup", "Restore", "Recover"]
    }
  ]

  firewall_ip_rules = [
    "1.1.1.1/32",
    "2.2.2.2/32",
    "3.3.3.3/32"
  ]

  tags = local.tags
}

resource "azurerm_key_vault_key" "example" {
  name         = "tfex-key-${random_id.this.hex}"
  key_vault_id = module.key_vault.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    module.key_vault.access_policies
  ]
}

module "storage" {
  # source = "github.com/equinor/terraform-azurerm-storage"
  source = "../.."

  account_name               = "st${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  firewall_ip_rules = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3"
  ]

  tags = local.tags
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = module.storage.id
  key_vault_id       = module.key_vault.id
  key_name           = azurerm_key_vault_key.example.name
}

