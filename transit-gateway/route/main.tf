# Add Transit Gateway as route 
resource "aws_route" "tw_route" {
  count                  = length(var.private_route_table_ids)
  route_table_id         = var.private_route_table_ids[count.index]
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = var.gateway_id
  
}