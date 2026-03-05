#################################
# Tokyo (ap-northeast-1) subnets
#################################

resource "aws_subnet" "shinjuku_private_a" {
  provider                = aws.tokyo
  vpc_id                  = aws_vpc.shinjuku.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = { Name = "shinjuku-private-a" }
}

resource "aws_subnet" "shinjuku_private_b" {
  provider                = aws.tokyo
  vpc_id                  = aws_vpc.shinjuku.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = { Name = "shinjuku-private-b" }
}

#################################
# São Paulo (sa-east-1) subnets
#################################

resource "aws_subnet" "liberdade_private_a" {
  provider                = aws.saopaulo
  vpc_id                  = aws_vpc.liberdade.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = false

  tags = { Name = "liberdade-private-a" }
}

resource "aws_subnet" "liberdade_private_b" {
  provider                = aws.saopaulo
  vpc_id                  = aws_vpc.liberdade.id
  cidr_block              = "10.20.2.0/24"
  availability_zone       = "sa-east-1b"
  map_public_ip_on_launch = false

  tags = { Name = "liberdade-private-b" }
}
