resource "aws_route53_zone" "jajaws_route_53_serverless_website" {
  name = var.domain_name
}

resource "aws_route53_record" "jajaws_route53_record_serverless_website" {
  depends_on = [ aws_route53_zone.jajaws_route_53_serverless_website ]

  zone_id = aws_route53_zone.jajaws_route_53_serverless_website.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                    = aws_cloudfront_distribution.jajaws_s3_distribution.domain_name
    zone_id                 = aws_cloudfront_distribution.jajaws_s3_distribution.hosted_zone_id
    evaluate_target_health  = false
  }
}