
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.1.0"
  ipv4_primary_cidr_block         = var.ipv4_primary_cidr_block
  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  availability_zones              = var.availability_zones
  igw_id                          = [module.vpc.igw_id]
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  max_subnet_count                = var.max_subnet_count
  nat_gateway_enabled             = var.nat_gateway_enabled
  nat_instance_enabled            = var.nat_instance_enabled
  nat_instance_type               = var.nat_instance_type
  subnet_type_tag_key             = var.subnet_type_tag_key
  subnet_type_tag_value_format    = var.subnet_type_tag_value_format
  vpc_id                          = module.vpc.vpc_id

  context = module.this.context
}
