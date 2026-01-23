terraform {
  required_providers {
    fabric = {
      source                = "microsoft/fabric"
      version               = "1.6.0"
      configuration_aliases = [fabric.auth]
    }
  }
}


data "azurerm_client_config" "current" {}

locals {
  workspace_name = substr(
    replace(
      var.workspace_name != null ? var.workspace_name : "${var.prefix}-${var.project}-fabricws${var.instance_number}",
      " ",
      ""
    ),
    0,
    30
  )
}

resource "fabric_workspace" "this" {
  provider     = fabric.auth
  display_name = local.workspace_name
  description  = var.description
  capacity_id  = var.capacity_id

  # identity = var.identity_type != "" ? {
  #   type = var.identity_type  # e.g., "SystemAssigned"
  # } : null

  # Optional identity: only if capacity exists and identity_type is set
  identity = var.capacity_id != null && var.identity_type != "" ? {
    type = var.identity_type
  } : null



  timeouts = {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}


# Grant Admin role to each owner (single, de-duplicated block)
resource "fabric_workspace_role_assignment" "admins" {
  provider     = fabric.auth
  for_each     = toset(var.owners)
  workspace_id = fabric_workspace.this.id
  principal = {
    id   = each.value
    type = "User"
  }
  role = "Admin"
}


# # Fabric Workspace Git Integration Resource
# resource "fabric_workspace_git" "this" {
#   count = var.enable_git_integration ? 1 : 0
#   workspace_id            = fabric_workspace.this.id
#   initialization_strategy = var.git_initialization_strategy
#   git_provider_details = var.git_provider_details

#   # Configure timeouts if provided
#   dynamic "timeouts" {
#     for_each = length([for k, v in var.timeouts_git : k if v != null]) > 0 ? [1] : []
#     content {
#       create = lookup(var.timeouts_git, "create", null)
#       read   = lookup(var.timeouts_git, "read", null)
#       update = lookup(var.timeouts_git, "update", null)
#       delete = lookup(var.timeouts_git, "delete", null)
#     }
#   }
# }
