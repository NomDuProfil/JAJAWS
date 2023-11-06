data "aws_cloudfront_cache_policy" "cache-optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_identity" "jajaws_cloudfront_s3_oia" {
  comment = "Jajaws origin for s3 bucket ${var.bucket_name}"
}

resource "aws_cloudfront_distribution" "jajaws_s3_distribution" {
  enabled               = true
  is_ipv6_enabled       = true
  default_root_object   = "index.html"
  price_class           = "PriceClass_100"

  origin {
    domain_name = aws_s3_bucket.jajaws_s3.bucket_regional_domain_name
    origin_id   = "S3-${var.bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.jajaws_cloudfront_s3_oia.cloudfront_access_identity_path
    }
  }

  custom_error_response {
    error_caching_min_ttl   = 0
    error_code              = 404
    response_code           = 200
    response_page_path      = "/index.html"
  }

  default_cache_behavior {
    allowed_methods         = ["GET", "HEAD"]
    cached_methods          = ["GET", "HEAD"]
    target_origin_id        = "S3-${var.bucket_name}"
    cache_policy_id         = data.aws_cloudfront_cache_policy.cache-optimized.id
    viewer_protocol_policy  = "redirect-to-https"
    min_ttl                 = 0
    default_ttl             = 3600
    max_ttl                 = 86400
    compress                = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate  = true
    ssl_support_method              = "sni-only"
    minimum_protocol_version        = "TLSv1.2_2021"
  }

}