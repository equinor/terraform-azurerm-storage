# terraform-azurerm-storage

Terraform module which creates an Azure Storage Account.

## Usage

```terraform
provider "azurerm" {
  features {}
}

locals {
  application = "my-app"
  environment = "example"
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${local.application}-${local.environment}"
  location = "northeurope"
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
```

## Test

### Prerequisites

- Install the latest version of [Go](https://go.dev/dl/).
- Install [Terraform](https://www.terraform.io/downloads).
- Configure your Azure credentials using one of the [options supported by the AzureRM provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure).

### Run test

```bash
cd ./test/
go test -v -timeout 60m
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.74.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.account_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.queue_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.queue_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.smb_share_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.smb_share_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.table_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.table_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for the storage account. | `string` | `"Hot"` | no |
| <a name="input_account_contributor"></a> [account\_contributor](#input\_account\_contributor) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. | `string` | `"Standard"` | no |
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_blob_change_feed_enabled"></a> [blob\_change\_feed\_enabled](#input\_blob\_change\_feed\_enabled) | Is change feed enabled for the storage account blob service? | `bool` | `false` | no |
| <a name="input_blob_contributor"></a> [blob\_contributor](#input\_blob\_contributor) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_blob_delete_retention_policy"></a> [blob\_delete\_retention\_policy](#input\_blob\_delete\_retention\_policy) | Specifies the number of days that the blobs and containers should be retained. | `number` | `30` | no |
| <a name="input_blob_reader"></a> [blob\_reader](#input\_blob\_reader) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_blob_versioning_enabled"></a> [blob\_versioning\_enabled](#input\_blob\_versioning\_enabled) | Is versioning enabled for the storage account blob service? | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_network_ip_rules"></a> [network\_ip\_rules](#input\_network\_ip\_rules) | List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. | `list(string)` | `[]` | no |
| <a name="input_queue_contributor"></a> [queue\_contributor](#input\_queue\_contributor) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_queue_reader"></a> [queue\_reader](#input\_queue\_reader) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |
| <a name="input_role_list"></a> [role\_list](#input\_role\_list) | List of object ID's | `string` | `"25d23649-cc47-49fa-bfd8-12acafc353a2"` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. | `bool` | `true` | no |
| <a name="input_smb_share_contributor"></a> [smb\_share\_contributor](#input\_smb\_share\_contributor) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_smb_share_reader"></a> [smb\_share\_reader](#input\_smb\_share\_reader) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the name of the storage account. | `string` | `null` | no |
| <a name="input_table_contributor"></a> [table\_contributor](#input\_table\_contributor) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_table_reader"></a> [table\_reader](#input\_table\_reader) | The ID's of the Principals that should be able to read and assign the User Assigned Identity. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->