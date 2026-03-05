resource "aws_vpc" "liberdade" {
  provider             = aws.saopaulo
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "liberdade-vpc"
  }
}