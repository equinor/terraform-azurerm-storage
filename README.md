# Azure Storage Terraform Module

[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-storage/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-storage/badge)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

Terraform module which creates an Azure Storage account.

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

1. Create a Terraform configuration file `main.tf` and add the following example configuration:

    ```terraform
    provider "azurerm" {
      storage_use_azuread = true

      features {}
    }

    resource "azurerm_resource_group" "example" {
      name     = "example-resources"
      location = "westeurope"
    }

    module "log_analytics" {
      source  = "equinor/log-analytics/azurerm"
      version = "~> 2.0"

      workspace_name      = "example-workspace"
      resource_group_name = azurerm_resource_group.example.name
      location            = azurerm_resource_group.example.location
    }

    module "storage" {
      source  = "equinor/storage/azurerm"
      version = "~> 12.0"

      account_name               = "example-storage"
      resource_group_name        = azurerm_resource_group.example.name
      location                   = azurerm_resource_group.example.location
      log_analytics_workspace_id = module.log_analytics.workspace_id

      network_rules_ip_rules = ["1.1.1.1", "2.2.2.2", "3.3.3.3/30"]
    }
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Install required provider plugins and modules:

    ```console
    terraform init
    ```

1. Apply the Terraform configuration:

    ```console
    terraform apply
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
