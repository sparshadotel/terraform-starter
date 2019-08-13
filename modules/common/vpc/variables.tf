variable "az_count" {
  type = "string"
  default = "2"
}

variable "tags" {
  type = "map"
  default = {
    Name = "Default"
    Project = "Default"
  }
}

variable "cidr_block" {
  type = "string"
  default = "172.17.0.0/16"
}
