#################################
# TGW Peering: Tokyo -> São Paulo
#################################

resource "aws_ec2_transit_gateway_peering_attachment" "shinjuku_to_liberdade" {
  provider = aws.tokyo

  transit_gateway_id      = aws_ec2_transit_gateway.shinjuku_tgw.id
  peer_transit_gateway_id = aws_ec2_transit_gateway.liberdade_tgw.id
  peer_region             = "sa-east-1"

  tags = {
    Name = "shinjuku-to-liberdade-peer"
  }
}

#################################
# TGW Peering Accepter: São Paulo
#################################

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "liberdade_accept_shinjuku" {
  provider = aws.saopaulo

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.shinjuku_to_liberdade.id

  tags = {
    Name = "liberdade-accept-shinjuku-peer"
  }
}
