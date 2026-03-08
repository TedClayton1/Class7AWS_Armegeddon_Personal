#################################
# Tokyo RDS Security Group
#################################

resource "aws_security_group" "shinjuku_rds_sg" {
  provider = aws.tokyo
  name     = "shinjuku-rds-sg"
  vpc_id   = aws_vpc.shinjuku.id

  ingress {
    description = "MySQL from Sao Paulo VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.liberdade.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shinjuku-rds-sg"
  }
}

#################################
# Tokyo DB Subnet Group
#################################

resource "aws_db_subnet_group" "shinjuku_db_subnet_group" {
  provider = aws.tokyo
  name     = "shinjuku-db-subnet-group"

  subnet_ids = [
    aws_subnet.shinjuku_private_a.id,
    aws_subnet.shinjuku_private_b.id
  ]

  tags = {
    Name = "shinjuku-db-subnet-group"
  }
}

#################################
# Tokyo MySQL RDS
#################################

resource "aws_db_instance" "shinjuku_rds" {
  provider = aws.tokyo

  identifier        = "shinjuku-rds"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "lab3adb"
  username = "adminuser"
  password = "ChangeMe1234!"
  port     = 3306

  db_subnet_group_name   = aws_db_subnet_group.shinjuku_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.shinjuku_rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false
  multi_az            = false

  tags = {
    Name = "shinjuku-rds"
  }
}

#################################
# Output
#################################

output "tokyo_rds_endpoint" {
  value = aws_db_instance.shinjuku_rds.address
}