terraform {
  backend "remote" {
    organization = "bcgov-tfc"

    workspaces {
      name = "nr-dap-fabric-ci-dev"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.0.1"
    }
    fabric = {
      source  = "microsoft/fabric"
      version = "1.6.0"
    }
  }
}
provider "azurerm" {
  skip_provider_registration = true
  features {}
}
provider "azapi" {
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
}
provider "fabric" {
  alias         = "auth"
  tenant_id     = var.ARM_TENANT_ID
  client_id     = var.ARM_CLIENT_ID
  client_secret = var.ARM_CLIENT_SECRET
}
