output "redis_endpoint" {
  value = aws_elasticache_cluster.redis_cluster.cluster_address
}