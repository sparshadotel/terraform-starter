resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name = var.redis_name
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "redis_sg" {
  name = "redis-sg-${var.redis_name}"
  tags = var.tags
  vpc_id = var.vpc_id
  ingress {
    from_port = 6379
    protocol = "tcp"
    to_port = 6379
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//resource "aws_elasticache_security_group" "redis_sg" {
//  name = "elasticcache-security-group-${var.redis_name}}"
//  security_group_names = [aws_security_group.redis_sg.name]
//}
resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id = var.redis_name
  engine = "redis"
  engine_version = var.redis_engine_version
  node_type = var.redis_node_type
  num_cache_nodes = 1
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.redis_sg.id]
  tags = var.tags
}
