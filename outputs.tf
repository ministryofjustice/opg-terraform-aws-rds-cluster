output "master_username" {
  value = aws_rds_cluster.cluster.master_username
}

output "port" {
  value = aws_rds_cluster.cluster.port
}

output "endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.cluster.reader_endpoint
}

output "name" {
  value = aws_rds_cluster.cluster.database_name
}

output "cluster" {
  value = aws_rds_cluster.cluster
}
