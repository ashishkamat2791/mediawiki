variable "ami" {
}

variable "key_name" {
}

variable "public_key_path" {
}

variable "private_key_path" {
  
}

variable "web_instance_type" {
}

variable "db_instance_type" {
}



variable "aws_profile" {
}

#for DB

variable "parameter_group" {
  default     = "default.postgres12"
  type        = string
  description = "Database engine parameter group"
}



variable "allocated_storage" {
  default     = "8"
  description = "storage to be used for database"
}

variable "max_allocated_storage" {
  default     = null
  type        = number
  description = "Specify Max Storage allocation which should be higher than allocated_storage for storage autoscaling"
}

variable "engine_version" {
  description = "engine version to be used for databse"
}

variable "instance_type" {
  description = "instance type to be used"
  default     = "db.t2.micro"
}

variable "storage_type" {
  default = "gp2"
}

variable "database_identifier" {
  default     = ""
  description = " Identifier for RDS instance"
}

variable "database_name" {
  description = "DB name"
}

variable "database_username" {
  description = "DB username"
}

variable "database_password" {
  description = "DB password"
}

variable "database_port" {
  description = "DB port"
}

variable "maintenance_window" {
  default     = "sun:04:30-sun:05:30"
  description = "maintenance window period"
}

variable "apply_immediately" {
  default     = true
  type        = bool
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window"
}

variable "backup_retention_period" {
  default     = 0
  type        = number
  description = "Number of days to keep database backups"
}

variable "deletion_protection" {
  default     = false
  type        = bool
  description = "Flag to protect the database instance from deletion"
}





