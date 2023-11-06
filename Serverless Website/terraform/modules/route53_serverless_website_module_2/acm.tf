provider "aws" {
    alias   = "jajaws_acm_provider_serverless_website"
    region  = "us-east-1"
}

resource "aws_acm_certificate" "jajaws_ssl_certificate_serverless_website" {
  provider          = aws.jajaws_acm_provider_serverless_website

  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "jajaws_route53_record_serverless_website_acm" {
    depends_on = [aws_route53_zone.jajaws_route_53_serverless_website]

    for_each = {
        for dvo in aws_acm_certificate.jajaws_ssl_certificate_serverless_website.domain_validation_options : dvo.domain_name => {
            name    = dvo.resource_record_name
            record  = dvo.resource_record_value
            type    = dvo.resource_record_type
        }
    }
    allow_overwrite   = true
    name              = each.value.name
    records           = [each.value.record]
    ttl               = 60
    type              = each.value.type
    zone_id           = aws_route53_zone.jajaws_route_53_serverless_website.zone_id
}

resource "aws_acm_certificate_validation" "jajaws_cert_validation_serverless_website" {
  provider = aws.jajaws_acm_provider_serverless_website
  
  certificate_arn         = aws_acm_certificate.jajaws_ssl_certificate_serverless_website.arn
  validation_record_fqdns = [for record in aws_route53_record.jajaws_route53_record_serverless_website_acm : record.fqdn]
}