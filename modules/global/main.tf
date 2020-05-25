module "vpc" {
  source = "../common/vpc"
  cidr_block = "172.11.0.0/16"
  tags = {
    Project = "My Awesome Project"
    Other = "Similar Tags"
  }
}

#module "acm" {
#  source = "../common/acm"
#  acm_domain_name = "*.mydomain.example.com"
#  acm_alternate_domain_names = "mydomain.example.com"
#  route53_root_domain = "mydomain.example.com"
#  tags = {
#    Project = "My Awesome Project"
#    Other = "Similar Tags"
#  }
#}
#
#module "alb" {
#  source = "../common/alb"
#  alb_name = "my-alb"
#  vpc_id = module.vpc.vpc_id
#  alb_security_group_name = "my-alb-security-group"
#  aws_acm_certificate_arn = module.acm.certificate_arn
#  alb_target_name = "my-alb-target-group"
#  public_subnets = module.vpc.public_subnets
#  tags = {
#    Project = "My Awesome Project"
#    Other = "Similar Tags"
#  }
#}
#
#module "cloudfront" {
#  source = "../common/cloudfront"
#  aws_acm_certificate_arn = module.acm.certificate_arn
#  cloudfront_domain_aliases = "mydomain.example.com"
#  bucket_name = "com.example.mydomain"
#  cloudfront_origin_id = "mydomain.example.com"
#  tags = {
#    Project = "My Awesome Project"
#    Other = "Similar Tags"
#  }
#}
#
#module "ec2" {
#  source = "../common/ec2"
#  ec2_instnace_name = "my-awesome-instance"
#  ec2_key_name = "my-awesome-key"
#  ec2_security_group_name = "my-awesome-ec2-security-group"
#  public_subnet_id = module.vpc.public_subnets[0]
#  vpc_id = module.vpc.vpc_id
#  tags = {
#    Project = "My Awesome Project"
#    OS = "Ubuntu"
#    Other = "Similar Tags"
#  }
#}
