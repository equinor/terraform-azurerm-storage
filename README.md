# Azure Storage Terraform Module

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)

Terraform module which creates an Azure Storage account.

## Usage

See [examples](examples).

## Development

1. Clone this repository:

    ```console
    git clone https://github.com/equinor/terraform-azurerm-storage.git
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Set environment variables:

    ```console
    export TF_VAR_resource_group_name=<RESOURCE_GROUP_NAME>
    export TF_VAR_location=<LOCATION>
    ```

## Testing

Run [unit tests](./tests/unit.tftest.hcl) for usage examples.

> These tests will only run `plan` in the background.
>
> To view the plan output, add `-verbose` to the `terraform test` command. This is recommended when executing specific tests, given the size of the output depending on the number of tests run.

1. Initialize working directory:

    ```console
    terraform init
    ```

1. Execute tests:

    ```console
    terraform test
    ```

### Execute a specific test

PowerShell:

```console
terraform test -filter='tests\<test_file>.tftest.hcl'
```

Windows:

```console
terraform test -filter=tests\<test_file>.tftest.hcl
```

Linux, Mac OS, and UNIX:

```console
terraform test -filter=tests/<test_file>.tftest.hcl
```

## Contributing

See [Contributing guidelines](CONTRIBUTING.md).
