output "endpoint" {
  value = module.rds_cluster_aurora_serverlessv2_postgres.endpoint
}

output "db_name" {
  value = module.rds_cluster_aurora_serverlessv2_postgres.name
}
