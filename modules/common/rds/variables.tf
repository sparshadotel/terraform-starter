variable "rds_storage" {
  default = 20
}

variable "rds_storage_type" {
  type = "string"
  default = "gp2"
}

variable "rds_engine" {
  type = "string"
  default = "postgres"
}

variable "rds_engine_version" {
  type = "string"
  default = "9.6.11"
}

variable "rds_name" {
  type = "string"
}

variable "rds_master_username" {
  type = "string"
}

variable "rds_master_password" {
  type = "string"
}

variable "rds_public_accessibility" {
  default = false
}

variable "tags" {
  type = "map"
  default = {
    Name = "RDS"
    Project = "Project"
  }
}

variable "rds_multi_az" {
  default = false
}

variable "rds_instance_class" {
  type = "string"
}

variable "rds_subnet_ids" {
  type = "list"
}

variable "rds_vpc_id" {
  type = "string"
}

variable "rds_vpc_cidr" {
  type = "string"
}

variable "rds_db_port" {
  default = 5432
}

variable "rds_parameter_group_name" {
  type = "string"
  default = "default.postgres9.6"
}
