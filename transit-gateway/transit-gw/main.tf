# -- transit-gw/main.tf -- # 

resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "Transit Gateway"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  tags = {
    "Name" = "Transit Gateway"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tw-att" {
  count              = length(var.vpc_ids)
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = var.vpc_ids[count.index]
  subnet_ids         = [var.subnet_ids[count.index]]
}

