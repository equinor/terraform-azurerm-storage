# terraform-azurerm-storage

Terraform module which creates an Azure Storage Account.

## Usage

```terraform
provider "azurerm" {
  # Required unless shared access key is explicitly enabled.
  storage_use_azuread = true

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

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-${local.application}-${local.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Free"
}

module "storage" {
  source = "github.com/equinor/terraform-azurerm-storage"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
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
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.account_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.file_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.file_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.queue_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.queue_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.table_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.table_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | The access tier to use for this Storage Account. | `string` | `"Hot"` | no |
| <a name="input_account_contributors"></a> [account\_contributors](#input\_account\_contributors) | The IDs of the Azure AD objects that should have Contributor access to this Storage Account. | `list(string)` | `[]` | no |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | A custom name for this Storage Account. | `string` | `null` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | The type of replication to use for this Storage Account. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The SKU tier to use for this Storage Account. | `string` | `"Standard"` | no |
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_blob_change_feed_enabled"></a> [blob\_change\_feed\_enabled](#input\_blob\_change\_feed\_enabled) | Is change feed enabled for this Blob Storage? | `bool` | `false` | no |
| <a name="input_blob_contributors"></a> [blob\_contributors](#input\_blob\_contributors) | The IDs of the Azure AD objects that should have Contributor access to this Blob Storage. | `list(string)` | `[]` | no |
| <a name="input_blob_delete_retention_policy"></a> [blob\_delete\_retention\_policy](#input\_blob\_delete\_retention\_policy) | The number of days that blobs and containers should be retained. | `number` | `30` | no |
| <a name="input_blob_readers"></a> [blob\_readers](#input\_blob\_readers) | The IDs of the Azure AD objects that should have Reader access to this Blob Storage. | `list(string)` | `[]` | no |
| <a name="input_blob_versioning_enabled"></a> [blob\_versioning\_enabled](#input\_blob\_versioning\_enabled) | Is versioning enabled for this Blob Storage? | `bool` | `false` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | The names of the Storage Containers to create in this Storage Account. Only lowercase alphanumeric characters and hyphens are allowed. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_file_contributors"></a> [file\_contributors](#input\_file\_contributors) | The IDs of the Azure AD objects that should have Contributor access to this File Storage. | `list(string)` | `[]` | no |
| <a name="input_file_readers"></a> [file\_readers](#input\_file\_readers) | The IDs of the Azure AD objects that should have Reader access to this File Storage. | `list(string)` | `[]` | no |
| <a name="input_file_retention_policy"></a> [file\_retention\_policy](#input\_file\_retention\_policy) | The number of days that files should be retained. | `number` | `30` | no |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace to send diagnostics to. | `string` | n/a | yes |
| <a name="input_network_ip_rules"></a> [network\_ip\_rules](#input\_network\_ip\_rules) | The public IPs or IP ranges in CIDR format that should be able to access this Storage Account. Only IPv4 addresses are allowed. | `list(string)` | `[]` | no |
| <a name="input_queue_contributors"></a> [queue\_contributors](#input\_queue\_contributors) | The IDs of the Azure AD objects that should have Contributor access to this Queue Storage. | `list(string)` | `[]` | no |
| <a name="input_queue_readers"></a> [queue\_readers](#input\_queue\_readers) | The IDs of the Azure AD objects that should have Reader access to this Queue Storage. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Is authorization with access key enabled for this Storage Account? | `bool` | `false` | no |
| <a name="input_table_contributors"></a> [table\_contributors](#input\_table\_contributors) | The IDs of the Azure AD objects that should have Contributor access to this Table Storage. | `list(string)` | `[]` | no |
| <a name="input_table_readers"></a> [table\_readers](#input\_table\_readers) | The IDs of the Azure AD objects that should have Reader access to this Table Storage. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | The ID of this Storage Account. |
| <a name="output_account_name"></a> [account\_name](#output\_account\_name) | The name of this Storage Account. |
| <a name="output_blob_endpoint"></a> [blob\_endpoint](#output\_blob\_endpoint) | The endpoint URL for this Blob Storage. |
| <a name="output_file_endpoint"></a> [file\_endpoint](#output\_file\_endpoint) | The endpoint URL of this File Storage. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for this Storage Account. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The primary connection string for this Storage Account. |
| <a name="output_queue_endpoint"></a> [queue\_endpoint](#output\_queue\_endpoint) | The endpoint URL for this Queue Storage. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for this Storage Account. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The secondary connection string for this Storage Account. |
| <a name="output_table_endpoint"></a> [table\_endpoint](#output\_table\_endpoint) | The endpoint URL for this Table Storage. |
<!-- END_TF_DOCS -->