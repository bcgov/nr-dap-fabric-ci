# modules/resource-group/variables.tf

variable "Instance_Number" {
  type        = string
  description = "Project name"
  default     = "00"
}

variable "project" {
  type        = string
  description = "Project name"
  default     = "dap"
}

variable "env" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
  default     = "nr"
}

variable "suffix" {
  type        = string
  description = "Resource name suffix"
  default     = "rg"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "cancadacentral"
}

variable "custom_rg_name" {
  description = "name of the resource group"
  type        = string
  default     = null
}


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
