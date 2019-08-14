resource "aws_acm_certificate" "certificate" {
  // Add the domain name to the certificate. Takes sting; Eg. "example.com" .If you want a wildcard certificate, add *.example.com
  domain_name = var.acm_domain_name
  validation_method = "DNS"

  // Add alternative domain names for the certificate. Takes a list; Eg. ["a.example.com", "b.example.com"] .If you have used wildcard as domain name add the domain root to this.
  subject_alternative_names = var.acm_alternate_domain_names
}

data "aws_route53_zone" "zone" {
  name = var.route53_root_domain
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  type = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = [
    aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value]
  ttl = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}