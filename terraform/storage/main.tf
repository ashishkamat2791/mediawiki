resource "aws_db_instance" "mysql" {
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage != null ? var.max_allocated_storage : null
  engine                          = "mysql"
  engine_version                  = var.engine_version
  identifier                      = var.database_identifier
  snapshot_identifier             = var.snapshot_identifier
  instance_class                  = var.instance_type
  storage_type                    = var.storage_type
  iops                            = var.iops
  name                            = var.database_name
  password                        = var.database_password
  username                        = var.database_username
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  maintenance_window              = var.maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  final_snapshot_identifier       = "${var.database_identifier}-final-snapshot"
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  multi_az                        = var.multi_availability_zone
  port                            = var.database_port
  vpc_security_group_ids          = var.vpc_security_group_ids
  db_subnet_group_name            = aws_db_subnet_group.mysql.name
  parameter_group_name            = var.parameter_group
  storage_encrypted               = var.storage_encrypted
  monitoring_interval             = var.monitoring_interval
  deletion_protection             = var.deletion_protection
  enabled_cloudwatch_logs_exports = var.cloudwatch_logs_exports
  apply_immediately               = var.apply_immediately
  tags                            = var.tags
  depends_on                      = [aws_db_subnet_group.mysql]
}

resource "aws_db_subnet_group" "mysql" {
  name       = "${var.database_identifier}-subnetgrp"
  subnet_ids = var.db_vpc_subnets
  tags       = var.tags
}
