terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  capacity_name       = substr(replace(var.capacity_name == null ? "${var.prefix}${var.project}${var.suffix}${var.Instance_Number}" : var.capacity_name, " ", ""), 0, 24)
  resource_group_name = substr(replace(var.resource_group_name == null ? "${var.prefix}${var.project}-rg${var.Instance_Number}" : var.resource_group_name, " ", ""), 0, 24)
  owners              = tolist(toset(concat(var.Default_Owners, var.Owners, [data.azurerm_client_config.this.object_id])))
}

output "owners" {
  value = local.owners
}

data "azurerm_client_config" "this" {}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_fabric_capacity" "this" {
  name                   = local.capacity_name
  resource_group_name    = azurerm_resource_group.this.name
  location               = var.location
  administration_members = local.owners

  sku {
    name = var.fabric_capacity_sku
    tier = "Fabric"
  }

  tags = var.tags
}
