variable "ec2_security_group_name" {
  type = "string"
}

variable "ec2_security_group_description" {
  type = "string"
  default = "EC2 Security Group Managed By Terraform"
}

variable "vpc_id" {
  type = "string"
}

variable "ec2_instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "public_subnet_id" {
  type = "string"
}

variable "ec2_key_name" {
  type = "string"
}

variable "ec2_cidr_blocks" {
  type = "list"
  default = [
    "0.0.0.0/0"
  ]
}

variable "image_filter_values" {
  type = "list"
  default = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
}

variable "virtualization_filter_values" {
  type = "list"
  default = ["hvm"]
}

variable "image_owners" {
  type = "list"
  default = ["099720109477"]
}

variable "tags" {
  type = "map"
  default = {
    Name = "Test"
    Project = "My Project"
  }
}

variable "ec2_instnace_name" {
  type = "string"
}

variable "ec2_volume_size" {
  type = "string"
  default = 30
}
