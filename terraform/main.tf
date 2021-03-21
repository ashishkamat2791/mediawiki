provider "aws" {
  region  = "us-east-1"
  profile = "mediawiki"
}

module "network" {
  source = "./network"
}

module "compute" {
  source          = "./compute"
  ami             = var.ami
  key_name        = var.key_name
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  aws_profile     = var.aws_profile

  web_instance_type  = var.web_instance_type
  web_security_group = module.network.web_security_group

  db_instance_type  = var.db_instance_type
  db_security_group = module.network.db_security_group
  db_root_password  = var.db_root_password

  web_subnet_a = module.network.web_subnet_a
  web_subnet_b = module.network.web_subnet_b
  db_subnet    = module.network.db_subnet
}

# module "storage" {
#   source = "./storage"
#   vpc_id                  = module.network.mw_vpc.id
#   vpc_security_group_ids  =  module.network.mw_sg_private.id
#   db_vpc_subnets          =  split(",",module.network.mw_sub_private_a.id,module.network.mw_sub_private_b.id)
#   allocated_storage       = var.allocated_storage
#   max_allocated_storage   = var.max_allocated_storage
#   engine_version          = var.engine_version
#   instance_type           = var.db_instance_type
#   storage_type            = var.storage_type
#   database_identifier     = var.database_identifier
#   database_name           = var.database_name
#   database_username       = var.database_username
#   database_password       = var.database_password
#   database_port           = var.database_port
#   backup_retention_period = var.backup_retention_period
#   parameter_group         = var.parameter_group
#   deletion_protection     = var.deletion_protection
#   apply_immediately       = var.apply_immediately

# }