resource "aws_security_group" "ec2" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = var.vpc_id
  tags        = var.tags

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = var.ec2_cidr_blocks
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "ec2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "default" {
  key_name = var.ec2_key_name
  public_key = tls_private_key.ec2.public_key_openssh
}

data "aws_ami" "image" {
    most_recent = true

    filter {
        name   = "name"
        values = var.image_filter_values
    }

    filter {
        name   = "virtualization-type"
        values = var.virtualization_filter_values
    }

    owners = var.image_owners
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ami.image.id
  instance_type = var.ec2_instance_type
  key_name = aws_key_pair.default.id
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  tags = var.tags

  root_block_device {
    volume_size = var.ec2_volume_size
    delete_on_termination = true
  }
}
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.ec2.id
  vpc = true
}


