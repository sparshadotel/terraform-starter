output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.cidr
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "acm_certificaite" {
  value = module.acm.certificate_arn
}

output "alb_domain_name" {
  value = module.alb.alb_dns_name
}

output "cloudfront_domain_name" {
  value = module.cloudfront.cloudfront_domain
}

output "ec2_ip" {
  value = module.ec2.public_ip
}

output "ec2_pem_file" {
  value = module.ec2.private_key_pem
}