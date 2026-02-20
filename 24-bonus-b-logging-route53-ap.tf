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
    name                   = aws_lb.bos_alb01.dns_name
    zone_id                = aws_lb.bos_alb01.zone_id
    evaluate_target_health = true
  }
}




resource "aws_route53_record" "app" {
  zone_id = "Z00361313J9Q4ZT1NXNVI"
  name    = "app.bowtiez.org"
  type    = "A"

  alias {
    name                   = aws_lb.bos_alb01.dns_name
    zone_id                = aws_lb.bos_alb01.zone_id
    evaluate_target_health = true
  }
}



