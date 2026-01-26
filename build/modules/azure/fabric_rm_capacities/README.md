<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.49.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_fabric_capacity.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.49.0/docs/resources/fabric_capacity) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.49.0/docs/resources/resource_group) | resource |
| [azurerm_client_config.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.49.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Default_Owners"></a> [Default\_Owners](#input\_Default\_Owners) | Additional owners to be added to the default owners. Must be passed as user object IDs from Azure AD / Entra ID. | `list(string)` | <pre>[<br>  "abigail.michel@gov.bc.ca",<br>  "Andrew.Schwenker@gov.bc.ca"<br>]</pre> | no |
| <a name="input_Instance_Number"></a> [Instance\_Number](#input\_Instance\_Number) | The instance number of capactities to create, ie: 2 capacities will create 2 capacities | `string` | n/a | yes |
| <a name="input_Owners"></a> [Owners](#input\_Owners) | The owner for specified capactities must be passed as a users object id from Azure AD / Entra ID defaults to Sebastian Hansen this must be the users upn | `list(any)` | <pre>[<br>  "abigail.michel@gov.bc.ca",<br>  "Andrew.Schwenker@gov.bc.ca"<br>]</pre> | no |
| <a name="input_capacity_name"></a> [capacity\_name](#input\_capacity\_name) | To overwride the naming formula for capacity name pass a value here | `string` | `null` | no |
| <a name="input_fabric_capacity_sku"></a> [fabric\_capacity\_sku](#input\_fabric\_capacity\_sku) | Fabric Capacity SKU name | `string` | `"F2"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Azure resources | `string` | `"canadacentral"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Default environment code ie: cdd,cdn,cdp | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of the project | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | To overwride the naming formula for resource group pass a value here | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Default resource type acronym ie: fabric capacity is fabcp | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Azure Resource Group | `map(string)` | <pre>{<br>  "application_environment": "dev",<br>  "client_code": "",<br>  "deployment_automation": "Terraform",<br>  "deployment_automation_version": "v0.1",<br>  "expense_authority": "",<br>  "information_security_classification": "protected_e",<br>  "ministry_name_prefix": "citz",<br>  "program_area": "permitting",<br>  "project_number": "",<br>  "responsibility_centre": "",<br>  "service_line": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fabric_capacity_id"></a> [fabric\_capacity\_id](#output\_fabric\_capacity\_id) | n/a |
| <a name="output_fabric_capacity_name"></a> [fabric\_capacity\_name](#output\_fabric\_capacity\_name) | n/a |
| <a name="output_fabric_resource_group_id"></a> [fabric\_resource\_group\_id](#output\_fabric\_resource\_group\_id) | n/a |
| <a name="output_fabric_resource_group_name"></a> [fabric\_resource\_group\_name](#output\_fabric\_resource\_group\_name) | n/a |
| <a name="output_owners"></a> [owners](#output\_owners) | n/a |
<!-- END_TF_DOCS -->