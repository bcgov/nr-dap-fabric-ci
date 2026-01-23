module "fabric_capacity_example" {
  source              = "../modules/azure/fabric_rm_capacities/"
  project             = "fabric"
  capacity_name       = null
  resource_group_name = null
  location            = "canadacentral"
  fabric_capacity_sku = "F4"
  prefix              = "nr"
  suffix              = "tools"
  Instance_Number     = "1"
  Owners              = ["abigail.michel@gov.bc.ca", "Andrew.Schwenker@gov.bc.ca", "sebastian.hansen@gov.bc.ca"]
}
