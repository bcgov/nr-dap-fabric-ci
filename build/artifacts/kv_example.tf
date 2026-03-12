# import {
#   to = module.key_vault.azurerm_key_vault.kv
#   id = "/subscriptions/ffc5e617-7f2d-4ddb-8b57-33fc43989a8c/resourceGroups/nrfabric-rg1/providers/Microsoft.KeyVault/vaults/nr-fabric-tools02"
# }

module "key_vault" {
  source = "../modules/azure/key_vaults"

  prefix                        = "nr"
  suffix                        = "tools"
  project                       = "fabric"
  env                           = var.ENVIRONMENT
  Instance_Number               = "02"
  resource_group_name           = "nrfabric-rg1"
  location                      = "canadacentral"
  public_network_access_enabled = false
  private_endpoint_enabled      = false
  private_endpoint_subnet_id    = "/subscriptions/ffc5e617-7f2d-4ddb-8b57-33fc43989a8c/resourceGroups/b9cee3-tools-networking/providers/Microsoft.Network/virtualNetworks/b9cee3-tools-vwan-spoke/subnets/privateendpoints-subnet"
  private_dns_zone_ids          = []
}

module "key_vault03" {
  source = "../modules/azure/key_vaults"

  prefix                        = "nr"
  suffix                        = "tools"
  project                       = "fabric"
  env                           = var.ENVIRONMENT
  Instance_Number               = "03"
  resource_group_name           = "nrfabric-rg1"
  location                      = "canadacentral"
  public_network_access_enabled = false
  private_endpoint_enabled      = false
  private_endpoint_subnet_id    = "/subscriptions/ffc5e617-7f2d-4ddb-8b57-33fc43989a8c/resourceGroups/b9cee3-tools-networking/providers/Microsoft.Network/virtualNetworks/b9cee3-tools-vwan-spoke/subnets/privateendpoints-subnet"
  private_dns_zone_ids          = []
}