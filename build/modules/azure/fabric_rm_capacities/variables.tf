variable "project" {
  description = "Name of the project"
  type        = string
}


variable "capacity_name" {
  description = "To overwride the naming formula for capacity name pass a value here "
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "To overwride the naming formula for resource group pass a value here "
  type        = string
  default     = null
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "canadacentral"
}

variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
  default     = "F2"
}

variable "suffix" {
  description = "Default resource type acronym ie: fabric capacity is fabcp"
  type        = string
}
variable "prefix" {
  description = "Default environment code ie: cdd,cdn,cdp"
  type        = string
}
variable "Instance_Number" {
  description = "The instance number of capactities to create, ie: 2 capacities will create 2 capacities"
  type        = string
}

# The owners variable is a bit strange for Service Principals it expects object id for users it must be their email. # 
variable "Owners" {
  description = "The owner for specified capactities must be passed as a users object id from Azure AD / Entra ID defaults to Sebastian Hansen this must be the users upn"
  type        = list(any)
  default     = ["abigail.michel@gov.bc.ca", "Andrew.Schwenker@gov.bc.ca"]
}

# The owners variable is a bit strange for Service Principals it expects object id for users it must be their email. # 
variable "Default_Owners" {
  description = "Additional owners to be added to the default owners. Must be passed as user object IDs from Azure AD / Entra ID."
  type        = list(string)
  default     = ["abigail.michel@gov.bc.ca", "Andrew.Schwenker@gov.bc.ca"]
}

# tagging variables #
variable "tags" {
  description = "Tags to apply to the Azure Resource Group"
  type        = map(string)
  default = {
    "ministry_name_prefix"                = "citz"
    "program_area"                        = "permitting"
    "client_code"                         = ""
    "responsibility_centre"               = ""
    "service_line"                        = ""
    "project_number"                      = ""
    "expense_authority"                   = ""
    "deployment_automation"               = "Terraform"
    "deployment_automation_version"       = "v0.1"
    "application_environment"             = "dev"
    "information_security_classification" = "protected_e"
  }
}