#################################
#Tokyo TGW Route Table
#################################
resource "aws_ec2_transit_gateway_route_table" "shinjuku_rt" {
  provider           = aws.tokyo
  transit_gateway_id = aws_ec2_transit_gateway.shinjuku_tgw.id

  tags = { Name = "shinjuku-tgw-rt" }
}


resource "aws_ec2_transit_gateway_route_table_propagation" "shinjuku_vpc_prop" {
  provider                       = aws.tokyo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt.id
}

# Tokyo TGW RT: route to Sao Paulo via peering
resource "aws_ec2_transit_gateway_route" "shinjuku_to_liberdade_cidr" {
  provider                       = aws.tokyo
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt.id
  destination_cidr_block         = aws_vpc.liberdade.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade.id
}



#################################
#Sao Paulo TGW Route Table
#################################
resource "aws_ec2_transit_gateway_route_table" "liberdade_rt" {
  provider           = aws.saopaulo
  transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw.id

  tags = { Name = "liberdade-tgw-rt" }
}


resource "aws_ec2_transit_gateway_route_table_propagation" "liberdade_vpc_prop" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.liberdade_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt.id
}

# Sao Paulo TGW RT: route to Tokyo via peering
resource "aws_ec2_transit_gateway_route" "liberdade_to_shinjuku_cidr" {
  provider                       = aws.saopaulo
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt.id
  destination_cidr_block         = aws_vpc.shinjuku.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_shinjuku.id
}

#################################
# Associations (move attachments onto our TGW RTs)
#################################

# Tokyo: associate VPC attachment to shinjuku_rt
resource "aws_ec2_transit_gateway_route_table_association" "shinjuku_vpc_assoc" {
  provider                       = aws.tokyo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shinjuku_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt.id
  replace_existing_association   = true
}

# Tokyo: associate peering attachment to shinjuku_rt
resource "aws_ec2_transit_gateway_route_table_association" "shinjuku_peer_assoc" {
  provider                       = aws.tokyo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.shinjuku_rt.id
  replace_existing_association   = true
}

# São Paulo: associate VPC attachment to liberdade_rt
resource "aws_ec2_transit_gateway_route_table_association" "liberdade_vpc_assoc" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.liberdade_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt.id
  replace_existing_association   = true
}

# São Paulo: associate peering attachment (accepter) to liberdade_rt
resource "aws_ec2_transit_gateway_route_table_association" "liberdade_peer_assoc" {
  provider                       = aws.saopaulo
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.liberdade_accept_shinjuku.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.liberdade_rt.id
  replace_existing_association   = true
}