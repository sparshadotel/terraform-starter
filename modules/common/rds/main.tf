resource "aws_security_group" "rds" {
  name        = var.rds_name
  description = var.rds_name
  vpc_id      = var.rds_vpc_id
  tags        = var.tags
  ingress {
    protocol    = "tcp"
    from_port   = var.rds_db_port
    to_port     = var.rds_db_port
    cidr_blocks = [var.rds_vpc_cidr]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = var.rds_name
  subnet_ids = var.rds_subnet_ids
  tags = var.tags
}

resource "aws_db_instance" "default" {
  identifier           = var.rds_name
  allocated_storage    = var.rds_storage
  storage_type         = var.rds_storage_type
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  port                 = var.rds_db_port
  name                 = var.rds_name
  username             = var.rds_master_username
  password             = var.rds_master_password
//  parameter_group_name = var.rds_parameter_group_name
  db_subnet_group_name      = aws_db_subnet_group.default.id
  vpc_security_group_ids    = [aws_security_group.rds.id]
  skip_final_snapshot       = true
  publicly_accessible = var.rds_public_accessibility
  tags = var.tags
}

