#################################
# Tokyo Transit Gateway
#################################

resource "aws_ec2_transit_gateway" "shinjuku_tgw" {
  provider = aws.tokyo

  description = "Tokyo TGW - Lab 3A"

  tags = {
    Name = "shinjuku-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shinjuku_attach" {
  provider = aws.tokyo

  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw.id
  vpc_id             = aws_vpc.shinjuku.id

  subnet_ids = [
    aws_subnet.shinjuku_private_a.id,
    aws_subnet.shinjuku_private_b.id
  ]

  tags = {
    Name = "shinjuku-tgw-attach"
  }
}

#################################
# São Paulo Transit Gateway
#################################

resource "aws_ec2_transit_gateway" "liberdade_tgw" {
  provider = aws.saopaulo

  description = "Sao Paulo TGW - Lab 3A"

  tags = {
    Name = "liberdade-tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "liberdade_attach" {
  provider = aws.saopaulo

  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw.id
  vpc_id             = aws_vpc.liberdade.id

  subnet_ids = [
    aws_subnet.liberdade_private_a.id,
    aws_subnet.liberdade_private_b.id
  ]

  tags = {
    Name = "liberdade-tgw-attach"
  }
}
