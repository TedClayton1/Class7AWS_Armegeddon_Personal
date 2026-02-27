############################################
# Bonus B - Route53 Zone Apex + ALB Access Logs to S3
############################################

############################################
# Route53: Zone Apex (root domain) -> ALB
############################################

# Explanation: The zone apex is the throne room—bos-growl.com itself should lead to the ALB.
resource "aws_route53_record" "bos_apex_alias01" {
  zone_id = local.bowtiez_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.cf.domain_name
    zone_id                = data.aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}




resource "aws_route53_record" "app" {
  zone_id = local.bowtiez_zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.cf.domain_name
    zone_id                = data.aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = false
  }
}



