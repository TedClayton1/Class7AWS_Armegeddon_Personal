# Step 0.A3 — DNS validation records for CloudFront ACM cert (us-east-1)
resource "aws_route53_record" "cf_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cf_cert.domain_validation_options :
    dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = local.bowtiez_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}
# Step 0.A4 — Validate/issue the CloudFront ACM cert
resource "aws_acm_certificate_validation" "cf_cert_validation" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.cf_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cf_cert_validation : r.fqdn]
}
