output "tokyo_vpc_id" {
  value = aws_vpc.shinjuku.id
}

output "saopaulo_vpc_id" {
  value = aws_vpc.liberdade.id
}

output "tokyo_vpc_cidr" {
  value = aws_vpc.shinjuku.cidr_block
}

output "saopaulo_vpc_cidr" {
  value = aws_vpc.liberdade.cidr_block
}