# Lab 2 – CloudFront origin cloaking

data "aws_ec2_managed_prefix_list" "cloudfront_origin" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

# resource "aws_security_group_rule" "alb_ingress_cf_only_443" {
#   type              = "ingress"
#   security_group_id = aws_security_group.bos_alb_sg01.id

#   from_port = 443
#   to_port   = 443
#   protocol  = "tcp"

#   prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront_origin.id]
# }


# resource "aws_vpc_security_group_ingress_rule" "bos_alb_https_from_cloudfront_lab2" {

#   security_group_id = aws_security_group.bos_alb_sg01.id

#   from_port   = 443
#   to_port     = 443
#   ip_protocol = "tcp"

#   prefix_list_id = data.aws_ec2_managed_prefix_list.cloudfront_origin.id
# }










