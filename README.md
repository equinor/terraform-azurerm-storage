# Azure Storage Terraform Module

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)

Terraform module which creates an Azure Storage account.

## Usage

See [examples](examples).

## Development

1. Read [this document](https://code.visualstudio.com/docs/devcontainers/containers).

1. Clone this repository.

1. Configure Terraform variables in a file `.devcontainer/devcontainer.env`:

    ```env
    TF_VAR_resource_group_name=
    TF_VAR_location=
    ```

1. Open repository in dev container.

## Testing

1. Change to the test directory:

    ```console
    cd test
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run tests:

    ```console
    go test -timeout 60m
    ```

## Contributing

See [Contributing guidelines](CONTRIBUTING.md).
test
