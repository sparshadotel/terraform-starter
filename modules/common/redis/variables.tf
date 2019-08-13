variable "subnet_ids" {
  type = "list"
}

variable "tags" {
  type = "map"
  default = {
    Project = "Project"
    Resource = "Redis"
  }
}

variable "redis_node_type" {
  type = "string"
  default = "cache.t2.medium"
}

variable "redis_name" {
  type = "string"
}

variable "redis_engine_version" {
  type = "string"
  default = "5.0.4"
}

variable "vpc_id" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
}
