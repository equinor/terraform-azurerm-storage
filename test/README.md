# Test

## Prerequisites

- Install the latest version of [Go](https://go.dev/dl/).
- Install the required version of [Terraform](https://www.terraform.io/downloads).
- Authenticate to Azure using one of the [methods supported by the Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure).

## Run tests

Change the current working directory to the test directory:

```
$ cd test
```

Execute test functions:

```
$ go test -v -timeout 30m
```
