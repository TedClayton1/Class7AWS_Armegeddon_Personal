#################################
# IAM for SSM (reuse same role in both regions)
#################################

data "aws_iam_policy" "ssm_core" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "lab3a_ssm_role" {
  name = "lab3a-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lab3a_ssm_attach" {
  role       = aws_iam_role.lab3a_ssm_role.name
  policy_arn = data.aws_iam_policy.ssm_core.arn
}

resource "aws_iam_instance_profile" "lab3a_instance_profile" {
  name = "lab3a-instance-profile"
  role = aws_iam_role.lab3a_ssm_role.name
}

#################################
# Security Groups (allow ping between VPCs)
#################################

resource "aws_security_group" "shinjuku_test_sg" {
  provider = aws.tokyo
  name     = "shinjuku-test-sg"
  vpc_id   = aws_vpc.shinjuku.id

  ingress {
    description = "ICMP from Sao Paulo VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.liberdade.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "shinjuku-test-sg" }
}

resource "aws_security_group" "liberdade_test_sg" {
  provider = aws.saopaulo
  name     = "liberdade-test-sg"
  vpc_id   = aws_vpc.liberdade.id

  ingress {
    description = "ICMP from Tokyo VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.shinjuku.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "liberdade-test-sg" }
}

#################################
# Latest Amazon Linux 2023 AMIs (per region)
#################################

data "aws_ami" "al2023_tokyo" {
  provider    = aws.tokyo
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_ami" "al2023_saopaulo" {
  provider    = aws.saopaulo
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

#################################
# EC2 instances (private subnets)
#################################

resource "aws_instance" "shinjuku_test_ec2" {
  provider               = aws.tokyo
  ami                    = data.aws_ami.al2023_tokyo.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.shinjuku_private_a.id
  vpc_security_group_ids = [aws_security_group.shinjuku_test_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.lab3a_instance_profile.name

  tags = { Name = "shinjuku-test-ec2" }
}

resource "aws_instance" "liberdade_test_ec2" {
  provider               = aws.saopaulo
  ami                    = data.aws_ami.al2023_saopaulo.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.liberdade_private_a.id
  vpc_security_group_ids = [aws_security_group.liberdade_test_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.lab3a_instance_profile.name

  tags = { Name = "liberdade-test-ec2" }
}

output "shinjuku_test_private_ip" {
  value = aws_instance.shinjuku_test_ec2.private_ip
}

output "liberdade_test_private_ip" {
  value = aws_instance.liberdade_test_ec2.private_ip
}
