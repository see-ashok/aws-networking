# -- vpc_peering/outputs.tf

output "vpc_peering_id" {
  value = aws_vpc_peering_connection.vpc_to_vpc.id
}