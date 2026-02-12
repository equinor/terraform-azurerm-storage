# Terraform module for Azure Storage

Terraform module which creates Azure Storage resources.

## Features

- Standard general-purpose v2 (GPv2) Storage account created by default.
- Microsoft Entra ID authorization enforced by default.
- Public network access denied by default.
- Read-access geo-redundant storage (RA-GRS) configured by default.
- Blob soft-delete retention set to 7 days by default.
- Blob point-in-time restore enabled by default.
- File soft-delete retention set to 7 days by default.
- Audit logs sent to given Log Analytics workspace by default.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {
  storage_use_azuread = true

  features {}
}

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "~> 12.14"

  account_name               = "examplestorage"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  network_rules_ip_rules = ["1.1.1.1", "2.2.2.2", "3.3.3.3/30"]
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.3"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

### Private endpoint

```terraform
provider "azurerm" {
  storage_use_azuread = true

  features {}
}

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "~> 12.13"

  account_name               = "stcontosodev"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id

  private_endpoints = {
    "blob" = {
      name                   = "pep-contoso-blob-dev"
      subnet_id              = module.network.subnet_ids["private_endpoints"]
      subresource_name       = "blob"
      private_dns_zone_ids   = [azurerm_private_dns_zone.blob_storage.id]
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "rg-contoso-dev"
  location = "westeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.3"

  workspace_name      = "log-contoso-dev"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

module "network" {
  source  = "equinor/network/azurerm"
  version = "~> 3.2"

  vnet_name           = "vnet-contoso-dev"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_spaces      = ["10.0.0.0/16"]

  subnets = {
    "private_endpoints" = {
      name             = "snet-private-endpoints"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

resource "azurerm_private_dns_zone" "blob_storage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_storage" {
  name                  = "link-${module.network.vnet_name}"
  private_dns_zone_name = azurerm_private_dns_zone.blob_storage.name
  resource_group_name   = azurerm_resource_group.example.name
  virtual_network_id    = module.network.vnet_id
}
```

## Testing

1. Initialize working directory:

    ```bash
    terraform init
    ```

1. Execute tests:

    ```bash
    terraform test
    ```

    See [`terraform test` command documentation](https://developer.hashicorp.com/terraform/cli/commands/test) for options.

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
