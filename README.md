# sgc-terraform-module-template
template for Terraform module repositories in Siedle Group Cloud organisation

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) | resource |
| [random_string.key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_user_assigned_identity.github_oidc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. | `string` | `""` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. | `bool` | `false` | no |
| <a name="input_cmk_lifetime_in_hours"></a> [cmk\_lifetime\_in\_hours](#input\_cmk\_lifetime\_in\_hours) | Validity for customer managed key in hours, e.g. 1 year = 8760 | `number` | `8760` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | Should cross Tenant replication be enabled? | `bool` | `false` | no |
| <a name="input_devops_object_id"></a> [devops\_object\_id](#input\_devops\_object\_id) | Entra ID object ID of the DevOps group to enable for Key Vault access. | `string` | n/a | yes |
| <a name="input_dns_zone_resource_group"></a> [dns\_zone\_resource\_group](#input\_dns\_zone\_resource\_group) | Name of resource group with the DNS zone to create records in | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (stage) to assign resources for. | `string` | n/a | yes |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Is infrastructure encryption enabled? | `bool` | `true` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Name of Key Vault to store customer managed storage encryption key in. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure Location (region) to create resources in. | `string` | n/a | yes |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account. | `string` | `""` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2 | `string` | `"TLS1_2"` | no |
| <a name="input_postfix"></a> [postfix](#input\_postfix) | Suffix definition providing predictable resource names | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Name of private dns zone to add A record of storage endpoint. | `string` | n/a | yes |
| <a name="input_private_link_endpoint_enabled"></a> [private\_link\_endpoint\_enabled](#input\_private\_link\_endpoint\_enabled) | Toggle private link endpoint creation for the storage account | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | Global project name as prefix and other naming and tagging functions. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable public network access to this storage account. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of resource group to add the storage account to. | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. | `bool` | `true` | no |
| <a name="input_shared_subnet_ids"></a> [shared\_subnet\_ids](#input\_shared\_subnet\_ids) | List ob subnet IDs of shared vnet to add to the storage account network acl | `list(string)` | n/a | yes |
| <a name="input_storage_access_tier"></a> [storage\_access\_tier](#input\_storage\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. | `string` | `""` | no |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | Defines the kind of storage for this storage accounts | `string` | `""` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. | `string` | n/a | yes |
| <a name="input_storage_account_prefix"></a> [storage\_account\_prefix](#input\_storage\_account\_prefix) | String to prefix storage account related resource names, depending on use case. | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | Account tier to use this storage account | `string` | `""` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID for this account in the resource group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of key/value pairs added to tag the storage account. | `map(string)` | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | Virtual network ID in use | `string` | n/a | yes |
| <a name="input_vnet_subnet_ids"></a> [vnet\_subnet\_ids](#input\_vnet\_subnet\_ids) | A list of resource ids for subnets that can access the storage account. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_storage_account_uri"></a> [storage\_account\_uri](#output\_storage\_account\_uri) | n/a |
<!-- END_TF_DOCS -->