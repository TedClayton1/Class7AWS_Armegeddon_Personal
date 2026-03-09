############################################
# Lab 2 - Route 53 -> CloudFront (Apex + app)
############################################



variable "cloudfront_distribution_id" {
  type        = string
  description = "CloudFront distribution ID, e.g. EWRZSYST7FTDH"
}

resource "aws_route53_record" "app" {
  zone_id = "Z00361313J9Q4ZT1NXNVI"
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "bos_apex_alias01" {
  zone_id = "Z00361313J9Q4ZT1NXNVI"
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}

# data "aws_route53_zone" "primary" {
#   name         = var.domain_name
#   private_zone = false
# }

# data "aws_cloudfront_distribution" "cf" {
#   id = var.cloudfront_distribution_id
# }

# Apex record: bowtiez.org -> CloudFront
# resource "aws_route53_record" "apex_to_cloudfront" {
#   zone_id = data.aws_route53_zone.primary.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = data.aws_cloudfront_distribution.cf.domain_name
#     zone_id                = data.aws_cloudfront_distribution.cf.hosted_zone_id
#     evaluate_target_health = false
#   }
# }

# app record: app.bowtiez.org -> CloudFront
# resource "aws_route53_record" "app_to_cloudfront" {
#   zone_id = data.aws_route53_zone.primary.zone_id
#   name    = "app.${var.domain_name}"
#   type    = "A"

#   alias {
#     name                   = data.aws_cloudfront_distribution.cf.domain_name
#     zone_id                = data.aws_cloudfront_distribution.cf.hosted_zone_id
#     evaluate_target_health = false
#   }
# }
