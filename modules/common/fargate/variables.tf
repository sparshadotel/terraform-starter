variable "fargate_cluster_name" {
  type = "string"
}

variable "faragte_app_name" {
  type = "string"
}

variable "fargate_app_count" {
  type = "string"
  default = "2"
}

variable "fargate_app_max_count" {
  type = "string"
  default = "6"
}

variable "fargate_app_min_count" {
  type = "string"
  default = "0"
}


variable "fargate_subnets" {
  description = "list of subnets that the fargate cluster is hosted at"
  type = "list"
}

variable "fargate_ignore_changes" {
  description = "Changes that needs to be ignored in case of redeployment"
  type = "list"
  default = ["desired_count"]
}

variable "fargate_cpu" {
  description = "1 CPU = 1024 Units"
  type = "string"
  default = "1024"
}

variable "fargate_memory" {
  description = "Fargate Task Definition Memory in MB"
  type = "string"
  default = "2048"
}

variable "fargate_task_execution_role_arn" {
  type = "string"
}

variable "fargate_autoscaling_role_arn" {
  type = "string"
}

variable "fargate_container_port" {
  type = "string"
}

variable "fargate_container_name" {
  type = "string"
}

variable "fargate_container_definitions" {
  description = "String format of container definition written in json"
  type = "string"
}

variable "vpc_id" {
  description = "VPC that fargate runs in"
  type = "string"
}

variable "tags" {
  type = "map"
  default = {
    Name = "Fargate"
    Project = "Sample"
  }
}

variable "fargate_alb_security_group_id" {
  type = "string"
}

variable "fargate_alb_target_group_id" {
  type = "string"
}

variable "cloudwatch_log_group" {
  type = "string"
  default = "log-group"
}
