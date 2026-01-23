<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resources.existing_resource_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resources) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Instance_Number"></a> [Instance\_Number](#input\_Instance\_Number) | Project name | `string` | `"00"` | no |
| <a name="input_custom_rg_name"></a> [custom\_rg\_name](#input\_custom\_rg\_name) | name of the resource group | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"cancadacentral"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource name prefix | `string` | `"nr"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"dap"` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Resource name suffix | `string` | `"rg"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Azure Resource Group | `map(string)` | <pre>{<br>  "application_environment": "dev",<br>  "client_code": "",<br>  "deployment_automation": "Terraform",<br>  "deployment_automation_version": "v0.1",<br>  "expense_authority": "",<br>  "information_security_classification": "protected_e",<br>  "ministry_name_prefix": "citz",<br>  "program_area": "permitting",<br>  "project_number": "",<br>  "responsibility_centre": "",<br>  "service_line": ""<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_existing_resource_group_count"></a> [existing\_resource\_group\_count](#output\_existing\_resource\_group\_count) | n/a |
| <a name="output_rg_id"></a> [rg\_id](#output\_rg\_id) | The ID of the created Azure Resource Group |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | The name of the created Azure Resource Group |
<!-- END_TF_DOCS -->