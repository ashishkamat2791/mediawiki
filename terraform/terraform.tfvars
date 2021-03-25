ami                 = "ami-042e8287309f5df03"
key_name            = "mediawiki"
public_key_path     = "mediawiki.pub"
private_key_path     = "mediawiki"
web_instance_type   = "t2.micro"
db_instance_type    = "t2.micro"
aws_profile         = "mediawiki"

## FOR DB
  allocated_storage       = 30
  engine_version          = "8.0.20"
  parameter_group         = "default.mysql8.0"
  instance_type           = "db.t2.micro"
  storage_type            = "gp2"
  database_identifier     = "mediawiki-dev"
  database_name           = "mediawiki"
  database_username       = "mediawiki"
  database_password       = "media123"
  database_port           = "3306"
  backup_retention_period = "0"

