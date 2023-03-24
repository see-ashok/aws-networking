# --transit-gw/outputs.tf -- # 

output "gateway_id" {
  value = aws_ec2_transit_gateway.transit_gateway.id
}