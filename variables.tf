variable "serverlessv2_scaling_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })
  default = {
    min_capacity = 1
    max_capacity = 1
  }
}

variable "engine" {
  type        = string
  description = "The database engine to use for the DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
  default     = "aurora-postgresql"
}

variable "engine_mode" {
  type        = string
  description = "The database engine mode. Valid values: `provisioned`, `serverless`"
  default     = "serverless"
}

variable "engine_version" {
  type        = string
  description = "The engine version to use. For Aurora MySQL, see the Aurora MySQL User Guide. For Aurora PostgreSQL, see the Aurora PostgreSQL User Guide."
  default     = "13.6"
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible."
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window."
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window."
  default     = false
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in."
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for. Must be between 1 and 35. Must be greater than 0 if the database is used as a source for a Read Replica."
  default     = 1
}

variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier."
}

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB cluster is created. Database will not be created if this parameter is not specified."
}

variable "db_subnet_group_name" {
  type        = string
  description = "A DB subnet group to associate with this DB cluster."
  default     = "default"
}

variable "deletion_protection" {
  type        = bool
  description = "Indicates if the DB cluster should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false."
  default     = false
}

variable "environment" {
  type        = string
  description = "The environment of the database."
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN for the KMS encryption key. When specifying `kms_key_arn`, `storage_encrypted` needs to be set to true."
  default     = null
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user."
}

variable "master_password" {
  type        = string
  description = "Password for the master DB user."
}

variable "replication_source_identifier" {
  type        = string
  description = "Specifies whether or not to create this cluster from a snapshot. This parameter is not case sensitive."
  default     = null
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB cluster snapshot is created before the DB cluster is deleted. If true is specified, no DB cluster snapshot is created. If false is specified, a DB cluster snapshot is created before the DB cluster is deleted, using the value from `final_snapshot_identifier`."
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted."
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of VPC security groups to associate with."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  default     = false
}

variable "instance_class" {
  type        = string
  description = "The instance class to use. For details on CPU and memory, see the Amazon Aurora User Guide."
  default     = "db.r5.large"
}

variable "cluster_instance_count" {
  type        = number
  description = "The number of instances in the DB cluster."
  default     = 1
}

variable "timeout_create" {
  type        = string
  description = "The maximum amount of time to wait for the DB cluster to be created."
  default     = "30m"
}

variable "timeout_update" {
  type        = string
  description = "The maximum amount of time to wait for the DB cluster to be updated."
  default     = "30m"
}

variable "timeout_delete" {
  type        = string
  description = "The maximum amount of time to wait for the DB cluster to be deleted."
  default     = "30m"
}

variable "publicly_accessible" {
  type        = bool
  description = "Specifies whether the DB cluster is publicly accessible."
  default     = false
}

variable "preferred_backup_window" {
  type        = string
  description = "The daily time range during which automated backups are created if automated backups are enabled, using the `backup_retention_period` parameter. The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. See the AWS documentation for more information."
  default     = "00:20-00:50"
}

variable "preferred_maintenance_window" {
  type        = string
  description = "The weekly time range (in UTC) during which system maintenance can occur, which might result in an outage. The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. See the AWS documentation for more information."
  default     = "sun:01:00-sun:01:30"
}

variable "psql_aurora_parameter_group_family" {
  type        = string
  description = "The family of the DB parameter group."
  default     = "aurora-postgresql13"
}
