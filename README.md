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
  version = "~> 12.13"

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
