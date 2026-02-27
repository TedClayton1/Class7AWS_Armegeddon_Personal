resource "aws_cloudfront_distribution" "cf" {
  enabled         = true
  is_ipv6_enabled = true
  http_version    = "http2"
  price_class     = "PriceClass_All"
  web_acl_id      = "arn:aws:wafv2:us-east-1:737679990112:global/webacl/CreatedByCloudFront-986a4211/bd2a73a7-5fd4-41bc-81d4-a5c9b85c59e8"

  aliases = [
    "app.bowtiez.org",
    "bowtiez.org",
    "www.bowtiez.org",
  ]

  tags = {
    Name = "Teds first CloudfFront"
  }

  origin {
    domain_name = "origin.bowtiez.org"
    origin_id   = "bos-alb01-1059849819.us-east-1.elb.amazonaws.com-ml1nn5k96fv"

    connection_attempts = 3
    connection_timeout  = 10

    custom_header {
      name  = "X-Origin-Verify"
      value = random_string.origin_header_value.result
    }

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"

      origin_read_timeout      = 30
      origin_keepalive_timeout = 5

      origin_ssl_protocols = [
        "SSLv3",
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  default_cache_behavior {
    target_origin_id       = "bos-alb01-1059849819.us-east-1.elb.amazonaws.com-ml1nn5k96fv"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    # Managed-CachingOptimized
    cache_policy_id = data.aws_cloudfront_cache_policy.caching_optimized.id
  }

  ordered_cache_behavior {
    path_pattern           = "/api/public-feed"
    target_origin_id       = "bos-alb01-1059849819.us-east-1.elb.amazonaws.com-ml1nn5k96fv"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    # UseOriginCacheControlHeaders-QueryStrings
    cache_policy_id = data.aws_cloudfront_cache_policy.origin_driven_qs.id
  }

  ordered_cache_behavior {
    path_pattern           = "/api/*"
    target_origin_id       = "bos-alb01-1059849819.us-east-1.elb.amazonaws.com-ml1nn5k96fv"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    # Managed-CachingDisabled
    cache_policy_id = data.aws_cloudfront_cache_policy.caching_disabled.id

    # Managed-AllViewer (you already have this data source in state)
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
  }

  ordered_cache_behavior {
    path_pattern           = "/static/*"
    target_origin_id       = "bos-alb01-1059849819.us-east-1.elb.amazonaws.com-ml1nn5k96fv"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    # Managed-CachingOptimized
    cache_policy_id = data.aws_cloudfront_cache_policy.caching_optimized.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:737679990112:certificate/4847695c-9909-4ba2-822b-6aee03007d43"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}