#############################################
# Lab 2b — Honors Origin-Driven Overlay
# 1) Reference AWS managed policies (data sources)
#############################################

# AWS-managed Cache Policies (grab by name)
data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

# AWS-managed Origin Request Policies (grab by name)
data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}

data "aws_cloudfront_origin_request_policy" "all_viewer_except_host" {
  name = "Managed-AllViewerExceptHostHeader"
}

# (Optional but common) AWS-managed Response Headers Policy
# If your overlay mentions security headers, CORS, etc.
data "aws_cloudfront_response_headers_policy" "security_headers" {
  name = "Managed-SecurityHeadersPolicy"
}

#############################################
# Example usage (attach to your distribution behaviors)
#############################################

# If you already have the distribution resource elsewhere,
# you’ll reference these like:
#
# default_cache_behavior {
#   cache_policy_id            = data.aws_cloudfront_cache_policy.caching_optimized.id
#   origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.all_viewer_except_host.id
#   response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers.id
# }
#
# ordered_cache_behavior {
#   path_pattern               = "/api/*"
#   cache_policy_id            = data.aws_cloudfront_cache_policy.caching_disabled.id
#   origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.all_viewer.id
# }