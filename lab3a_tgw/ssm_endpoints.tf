resource "aws_security_group" "shinjuku_vpce_sg" {
  provider = aws.tokyo
  vpc_id   = aws_vpc.shinjuku.id

  ingress {
    description = "HTTPS from Tokyo VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.shinjuku.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "shinjuku-vpce-sg" }
}


resource "aws_security_group" "liberdade_vpce_sg" {
  provider = aws.saopaulo
  name     = "liberdade-vpce-sg"
  vpc_id   = aws_vpc.liberdade.id

  ingress {
    description = "HTTPS from Sao Paulo VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.liberdade.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "liberdade-vpce-sg" }
}


resource "aws_vpc_endpoint" "shinjuku_ssm" {
  provider            = aws.tokyo
  vpc_id              = aws_vpc.shinjuku.id
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.shinjuku_private_a.id, aws_subnet.shinjuku_private_b.id]
  security_group_ids = [aws_security_group.shinjuku_vpce_sg.id]

  tags = { Name = "shinjuku-ssm-vpce" }
}

resource "aws_vpc_endpoint" "shinjuku_ec2messages" {
  provider            = aws.tokyo
  vpc_id              = aws_vpc.shinjuku.id
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids = [aws_subnet.shinjuku_private_a.id, aws_subnet.shinjuku_private_b.id]

  tags = { Name = "shinjuku-ec2messages-vpce" }
}

resource "aws_vpc_endpoint" "shinjuku_ssmmessages" {
  provider            = aws.tokyo
  vpc_id              = aws_vpc.shinjuku.id
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.shinjuku_private_a.id, aws_subnet.shinjuku_private_b.id]
  security_group_ids = [aws_security_group.shinjuku_vpce_sg.id]

  tags = { Name = "shinjuku-ssmmessages-vpce" }
}

resource "aws_vpc_endpoint" "liberdade_ssm" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade.id
  service_name        = "com.amazonaws.sa-east-1.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [aws_subnet.liberdade_private_a.id, aws_subnet.liberdade_private_b.id]
  security_group_ids  = [aws_security_group.liberdade_vpce_sg.id]

  tags = { Name = "liberdade-ssm-vpce" }
}

resource "aws_vpc_endpoint" "liberdade_ec2messages" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade.id
  service_name        = "com.amazonaws.sa-east-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.liberdade_private_a.id, aws_subnet.liberdade_private_b.id]
  security_group_ids = [aws_security_group.liberdade_vpce_sg.id]


  tags = { Name = "liberdade-ec2messages-vpce" }
}

resource "aws_vpc_endpoint" "liberdade_ssmmessages" {
  provider            = aws.saopaulo
  vpc_id              = aws_vpc.liberdade.id
  service_name        = "com.amazonaws.sa-east-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.liberdade_private_a.id, aws_subnet.liberdade_private_b.id]
  security_group_ids = [aws_security_group.liberdade_vpce_sg.id]

  tags = { Name = "liberdade-ssmmessages-vpce" }
}
