locals {
  fabric_warehouse = var.fabric_warehouse != null ? var.fabric_warehouse : "${var.prefix}-${var.project}-fabwh${var.instance_number}"
  workspace_name   = var.workspace_name != null ? var.workspace_name : "${var.prefix}-${var.project}-fabwh${var.instance_number}"
}

data "fabric_workspace" "this_workspace" {
  display_name = local.workspace_name
}

resource "fabric_warehouse" "this_warehouse" {
  display_name = local.fabric_warehouse
  workspace_id = data.fabric_workspace.this_workspace.id
}