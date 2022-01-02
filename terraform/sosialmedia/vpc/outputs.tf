output "vpc_id" {
  value = module.sosialmedia_vpc.vpc_id
}

output "public_subnets_id" {
  value = module.sosialmedia_vpc.public_subnets
}




output "vpc_cidr_blocks" {
  value = module.sosialmedia_vpc.vpc_cidr_block
}


output "public_subnet_cidr_blocks" {
  value = module.sosialmedia_vpc.public_subnets_cidr_blocks
}


output "database_subnets_id"{
  value = module.sosialmedia_vpc.database_subnets
}
