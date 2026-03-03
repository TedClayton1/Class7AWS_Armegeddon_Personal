resource "aws_vpc" "liberdade" {
  provider   = aws.saopaulo
  cidr_block = "10.20.0.0/16"

  tags = {
    Name = "liberdade-vpc"
  }
}