#################################
# Tokyo private route table + associations
#################################

resource "aws_route_table" "shinjuku_private_rt" {
  provider = aws.tokyo
  vpc_id   = aws_vpc.shinjuku.id

  tags = { Name = "shinjuku-private-rt" }
}

resource "aws_route_table_association" "shinjuku_private_a_assoc" {
  provider       = aws.tokyo
  subnet_id      = aws_subnet.shinjuku_private_a.id
  route_table_id = aws_route_table.shinjuku_private_rt.id
}

resource "aws_route_table_association" "shinjuku_private_b_assoc" {
  provider       = aws.tokyo
  subnet_id      = aws_subnet.shinjuku_private_b.id
  route_table_id = aws_route_table.shinjuku_private_rt.id
}

# Tokyo -> São Paulo route via Tokyo TGW
resource "aws_route" "shinjuku_to_liberdade" {
  provider               = aws.tokyo
  route_table_id         = aws_route_table.shinjuku_private_rt.id
  destination_cidr_block = aws_vpc.liberdade.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.shinjuku_tgw.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade,
    aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach
  ]
}

#################################
# São Paulo private route table + associations
#################################

resource "aws_route_table" "liberdade_private_rt" {
  provider = aws.saopaulo
  vpc_id   = aws_vpc.liberdade.id

  tags = { Name = "liberdade-private-rt" }
}

resource "aws_route_table_association" "liberdade_private_a_assoc" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_private_a.id
  route_table_id = aws_route_table.liberdade_private_rt.id
}

resource "aws_route_table_association" "liberdade_private_b_assoc" {
  provider       = aws.saopaulo
  subnet_id      = aws_subnet.liberdade_private_b.id
  route_table_id = aws_route_table.liberdade_private_rt.id
}

# São Paulo -> Tokyo route via São Paulo TGW
resource "aws_route" "liberdade_to_shinjuku" {
  provider               = aws.saopaulo
  route_table_id         = aws_route_table.liberdade_private_rt.id
  destination_cidr_block = aws_vpc.shinjuku.cidr_block
  transit_gateway_id     = aws_ec2_transit_gateway.liberdade_tgw.id

  depends_on = [
    aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_shinjuku,
    aws_ec2_transit_gateway_vpc_attachment.liberdade_attach
  ]
}
