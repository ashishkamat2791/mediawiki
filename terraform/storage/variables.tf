variable "project" {
  default     = ""
  type        = string
  description = "This variable is used for tagging"
}

variable "allocated_storage" {
  default     = 32
  type        = number
  description = "Storage allocated to database instance"
}

variable "max_allocated_storage" {
  default     = null
  type        = number
  description = "Specify Max Storage allocation which should be higher than allocated_storage for storage autoscaling"
}

variable "engine_version" {
  default     = "10.9"
  type        = string
  description = "Database engine version"
}

variable "instance_type" {
  default     = "db.t3.micro"
  type        = string
  description = "Instance type for database instance"
}

variable "storage_type" {
  default     = "gp2"
  type        = string
  description = "Type of underlying storage for database"
}

variable "iops" {
  default     = 0
  type        = number
  description = "The amount of provisioned IOPS"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC meant to house database"
}

variable "vpc_security_group_ids" {
  type        = list
  description = "security group ids to pass"
}

variable "database_identifier" {
  type        = string
  description = "Identifier for RDS instance"
}

variable "snapshot_identifier" {
  default     = ""
  type        = string
  description = "The name of the snapshot (if any) the database should be created from"
}

variable "database_name" {
  type        = string
  description = "Name of database inside storage engine"
}

variable "database_username" {
  type        = string
  description = "Name of user inside storage engine"
}

variable "database_password" {
  type        = string
  description = "Database password inside storage engine"
}

variable "database_port" {
  default     = 3306
  type        = number
  description = "Port on which database will accept connections"
}

variable "backup_retention_period" {
  default     = 0
  type        = number
  description = "Number of days to keep database backups"
}

variable "backup_window" {
  # 01:30AM-02:00AM IST
  default     = "20:00-20:30"
  type        = string
  description = "30 minute time window to reserve for backups"
}

variable "maintenance_window" {
  # SUN 03:30AM-04:30AM IST
  default     = "sun:22:00-sun:23:00"
  type        = string
  description = "60 minute time window to reserve for maintenance"
}

variable "apply_immediately" {
  default     = true
  type        = bool
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window"
}

variable "auto_minor_version_upgrade" {
  default     = true
  type        = bool
  description = "Minor engine upgrades are applied automatically to the DB instance during the maintenance window"
}

variable "skip_final_snapshot" {
  default     = true
  type        = bool
  description = "Flag to enable or disable a snapshot if the database instance is terminated"
}

variable "copy_tags_to_snapshot" {
  default     = false
  type        = bool
  description = "Flag to enable or disable copying instance tags to the final snapshot"
}

variable "multi_availability_zone" {
  default     = false
  type        = bool
  description = "Flag to enable hot standby in another availability zone"
}

variable "storage_encrypted" {
  default     = false
  type        = bool
  description = "Flag to enable storage encryption"
}

variable "monitoring_interval" {
  default     = 0
  type        = number
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
}

variable "deletion_protection" {
  default     = true
  type        = bool
  description = "Flag to protect the database instance from deletion"
}

variable "cloudwatch_logs_exports" {
  default     = []
  type        = list
  description = "Possible log-group exporters are postgresql,upgrade"
}

variable "db_vpc_subnets" {
  type        = list
  description = "Database vpc subnets"
  default     = []
}

variable "parameter_group" {
  default     = "default.postgres12"
  type        = string
  description = "Database engine parameter group"
}

variable "alarm_cpu_threshold" {
  default     = 75
  type        = number
  description = "CPU alarm threshold as a percentage"
}

variable "alarm_disk_queue_threshold" {
  default     = 10
  type        = number
  description = "Disk queue alarm threshold"
}

variable "alarm_free_disk_threshold" {
  # 5GB
  default     = 5000000000
  type        = number
  description = "Free disk alarm threshold in bytes"
}

variable "alarm_free_memory_threshold" {
  # 128MB
  default     = 128000000
  type        = number
  description = "Free memory alarm threshold in bytes"
}

variable "alarm_cpu_credit_balance_threshold" {
  default     = 30
  type        = number
  description = "CPU credit balance threshold (only for db.t* instance types)"
}

variable "alarm_actions" {
  type        = list
  description = "List of ARNs to be notified via CloudWatch when alarm enters ALARM state"
  default     = []
}

variable "ok_actions" {
  type        = list
  description = "List of ARNs to be notified via CloudWatch when alarm enters OK state"
  default     = []
}

variable "insufficient_data_actions" {
  type        = list
  description = "List of ARNs to be notified via CloudWatch when alarm enters INSUFFICIENT_DATA state"
  default     = []
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "tags to attach to the RDS resources"
}
