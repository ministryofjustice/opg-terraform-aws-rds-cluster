data "aws_caller_identity" "current" {}

resource "aws_rds_cluster" "cluster" {
  apply_immediately               = var.apply_immediately
  availability_zones              = var.availability_zones
  backup_retention_period         = var.backup_retention_period
  cluster_identifier              = "${var.cluster_identifier}-${var.environment}"
  database_name                   = var.database_name
  db_subnet_group_name            = var.db_subnet_group_name
  deletion_protection             = var.deletion_protection
  engine                          = var.engine
  engine_version                  = var.engine_version
  engine_mode                     = var.engine_mode
  enabled_cloudwatch_logs_exports = ["postgresql"]
  final_snapshot_identifier       = "${var.database_name}-${var.environment}-final-snapshot"
  # TODO: Add support for custom parameter groups
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.postgres-aurora-params.name
  kms_key_id                          = var.kms_key_arn
  master_username                     = var.master_username
  master_password                     = var.master_password
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  replication_source_identifier       = var.replication_source_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  storage_encrypted                   = var.storage_encrypted
  vpc_security_group_ids              = var.vpc_security_group_ids
  tags                                = var.tags
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverlessv2_scaling_configuration[*]
    content {
      max_capacity = serverlessv2_scaling_configuration.value.max_capacity
      min_capacity = serverlessv2_scaling_configuration.value.min_capacity
    }
  }

}

resource "aws_rds_cluster_instance" "default" {
  count                           = var.cluster_instance_count
  apply_immediately               = var.apply_immediately
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  db_subnet_group_name            = var.db_subnet_group_name
  cluster_identifier              = aws_rds_cluster.cluster.id
  engine                          = aws_rds_cluster.cluster.engine
  engine_version                  = aws_rds_cluster.cluster.engine_version
  identifier                      = "${aws_rds_cluster.cluster.id}-${count.index}"
  instance_class                  = "db.serverless"
  monitoring_interval             = 30
  monitoring_role_arn             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/rds-enhanced-monitoring"
  performance_insights_enabled    = true
  performance_insights_kms_key_id = var.kms_key_arn
  publicly_accessible             = var.publicly_accessible
  tags                            = var.tags

  timeouts {
    create = var.timeout_create
    update = var.timeout_update
    delete = var.timeout_delete
  }


}

resource "aws_rds_cluster_parameter_group" "postgres-aurora-params" {
  name        = lower("postgres13-db-params-${var.environment}")
  description = "default postgres13 aurora parameter group"
  family      = var.psql_aurora_parameter_group_family
  parameter {
    name         = "log_min_duration_statement"
    value        = "500"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_statement"
    value        = "none"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_duration"
    value        = "1"
    apply_method = "immediate"
  }

  parameter {
    name         = "rds.log_retention_period"
    value        = "1440"
    apply_method = "immediate"
  }
}
