// All of these variables have no default values and must be set by the user

variable "master_username" {
  type        = string
  description = "The master username for the DB cluster"
}

variable "master_password" {
  type        = string
  description = "The master password for the DB cluster"
}

variable "database_name" {
  type        = string
  description = "The name of the database to create when the DB cluster is created"
}

variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier"
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of EC2 Availability Zones that instances in the DB cluster can be created in"
}
