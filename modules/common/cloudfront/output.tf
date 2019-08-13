output "cloudfront_domain" {
  value = aws_cloudfront_distribution.www_distribution.domain_name
}
