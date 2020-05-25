variable "az_count" {
  type = "string"
  default = "2"
}

variable "tags" {
  type = "map"
  default = {
    Name = "TF-Starter"
    Project = "TF-Starter"
  }
}

variable "project_name" {
  default = "tfstarter"
}

variable "stage" {
  default = "sandbox"
}

variable "cidr_block" {
  type = "string"
  default = "172.17.0.0/16"
}
