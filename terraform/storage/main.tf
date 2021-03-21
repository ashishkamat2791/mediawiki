resource "aws_db_instance" "default" {
  identifier                          = var.db_identifier
  allocated_storage                   = var.db_allocated_storage
  storage_type                        = var.db_storage_type
  engine                              = var.db_engine
  engine_version                      = var.db_engine_version
  instance_class                      = var.instance_class
  name                                = var.db_name
  username                            = var.db_username
  password                            = var.db_password
  port                                = var.db_port
  parameter_group_name                = "default.mysql5.7"
  auto_minor_version_upgrade          = var.auto_mirror
  backup_retention_period             = var.backup_retention_period
  maintenance_window                  = var.maintenance_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  db_subnet_group_name                = aws_db_subnet_group.default_subnet_group.name
  deletion_protection                 = var.deletion_protection
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  multi_az                            = var.multi_az
  performance_insights_enabled        = var.performance_insights_enabled
  publicly_accessible                 = var.publicly_accessible
  storage_encrypted                   = var.storage_encrypted
  vpc_security_group_ids              = [aws_security_group.aws_rds_security_group.id]
  skip_final_snapshot                 = var.skip_final_snapshot
  depends_on                          = ["aws_security_group.aws_rds_security_group", "aws_db_subnet_group.default_subnet_group"]
  tags                                = var.tags
}

resource "aws_security_group" "aws_rds_security_group" {
  name        = "RDS SG ${var.deployment_environment}"
  description = "Ingress/Egress rules for ec2 servers"
  vpc_id      = var.aws_vpc_id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}

resource "aws_db_subnet_group" "default_subnet_group" {
  name       = "${var.db_identifier}-db_subnet_group"
  subnet_ids = split(",", var.private_subnet_ids)
  tags       = var.tags
}
