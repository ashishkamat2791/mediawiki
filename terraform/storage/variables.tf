variable "aws_vpc_id" {
  description = "specify VPC ID for rds instance creation"
}

variable "private_subnet_ids" {
  default     = ""
  description = "specify subnet ids for RDS instance creation"
}

variable "deployment_environment" {
  description = "specify enviornment name"
}

variable "db_identifier" {
  description = "specify DB identifier class"
}

variable "db_allocated_storage" {
  default     = 30
  description = "specify db storage allocation"
}

variable "db_engine" {
  description = "specify DB_engine to be used"
}

variable "db_engine_version" {
  description = "specify DB engine version"
}

variable "db_port" {
  description = "specify DB port to be used"
}

variable "db_username" {
  description = "specify DB username"
}

variable "db_password" {
  description = "specify DB password"
}

variable "instance_class" {
  description = "specify type of instacne class to be used"
}

variable "db_storage_type" {
  default     = "gp2"
  description = "type of storage type to be used"
}

variable "db_name" {
  description = "DB name to be given"
}

variable "auto_mirror" {
  default     = "false"
  description = "If mirroring to be enabled"
}

variable "backup_retention_period" {
  default     = 0
  description = "period to keep backup of DB snapshot"
}

variable "maintenance_window" {
  default     = ""
  description = "maintenance window (in days)"
}

variable "copy_tags_to_snapshot" {
  default     = "true"
  description = "whether to copy tags to snapshots"
}

variable "deletion_protection" {
  default     = "true"
  description = "whether to delete snapshot and protection flag"
}

variable "iam_database_authentication_enabled" {
  default     = "false"
  description = "if IAM authentication to be enabled"
}

variable "multi_az" {
  default     = "false"
  description = "whether DB instacne should be multi AZ"
}

variable "performance_insights_enabled" {
  default     = "false"
  description = "whether performance insights to be enabled"
}

variable "publicly_accessible" {
  default     = "false"
  description = "whether DB to be accessible publicly"
}

variable "storage_encrypted" {
  default     = "false"
  description = "whether storage to be encrypted"
}

variable "skip_final_snapshot" {
  default     = "false"
  description = "whether final snapshot to be taken before DB deletion"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
