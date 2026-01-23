locals {
  fabric_domain_parent = var.fabric_domain_parent != "" ? var.fabric_domain_parent : "${var.prefix}-${var.project}-fabdp${var.instance_number}"
  fabric_domain_child  = var.fabric_domain_child != "" ? var.fabric_domain_child : "${var.prefix}-${var.project}-fabdc${var.instance_number}"
}

resource "fabric_domain" "parent" {
  description        = var.fabric_child_description
  display_name       = local.fabric_domain
  contributors_scope = var.contributors_scope
}

# Conditionally create child domains based on enable_child_domain
resource "fabric_domain" "child" {
  count            = var.enable_child_domain ? length(var.child_subdomains) : 0
  display_name     = var.enable_child_domain && var.fabric_domain_child != "" && var.fabric_domain_child != null ? "${var.fabric_domain_child}-${count.index + 1}" : "${local.fabric_domain_child_base}-${count.index + 1}"
  description      = var.description
  parent_domain_id = fabric_domain.parent.id
}