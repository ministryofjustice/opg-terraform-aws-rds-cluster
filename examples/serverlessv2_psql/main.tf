provider "aws" {}

module "rds_cluster_aurora_serverlessv2_postgres" {
  source = "../../"

  engine                 = "aurora-postgresql"
  engine_version         = "13.6"
  cluster_instance_count = 1
  instance_class         = "db.serverless"
  engine_mode            = "provisioned"
  environment            = "test"
  database_name          = var.database_name
  master_username        = var.master_username
  master_password        = var.master_password
  cluster_identifier     = var.cluster_identifier



  serverlessv2_scaling_configuration = {
    max_capacity = 3
    min_capacity = 1
  }
}
