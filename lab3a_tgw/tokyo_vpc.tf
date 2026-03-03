resource "aws_vpc" "shinjuku" {
  provider   = aws.tokyo
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "shinjuku-vpc"
  }
}