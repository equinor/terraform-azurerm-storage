# Terraform module for Azure Storage

[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-storage)](https://github.com/equinor/terraform-azurerm-storage/blob/main/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-storage)](https://github.com/equinor/terraform-azurerm-storage/releases/latest)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-storage/badge)](https://developer.equinor.com/governance/scm-policy/)

Terraform module which creates Azure Storage resources.

## Features

- Microsoft Entra ID authorization enforced by default.
- Public network access denied by default.
- Read-access geo-redundant storage (RA-GRS) configured by default.
- Blob soft-delete retention set to 7 days by default.
- Blob point-in-time restore enabled by default.
- File soft-delete retention set to 7 days by default.
- Audit logs sent to given Log Analytics workspace by default.

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/install).
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Create a Terraform configuration file `main.tf` and add the following example configuration:

    ```terraform
    provider "azurerm" {
      storage_use_azuread = true

      features {}
    }

    module "storage" {
      source  = "equinor/storage/azurerm"
      version = "~> 12.11"

      account_name               = "example-storage"
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

1. Install required provider plugins and modules:

    ```console
    terraform init
    ```

1. Apply the Terraform configuration:

    ```console
    terraform apply
    ```

## Development

1. Login to Azure:

    ```bash
    az login
    ```

1. Set environment variables:

    ```bash
    export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
    export TF_VAR_resource_group_name="<RESOURCE_GROUP_NAME>"
    export TF_VAR_location="<LOCATION>"
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
