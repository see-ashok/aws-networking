data "aws_route_tables" "rts" {
  vpc_id = var.vpc_id
}

resource "aws_route" "peering_routes" {
  count                     = length(data.aws_route_tables.rts.ids)
  route_table_id            = tolist(data.aws_route_tables.rts.ids)[count.index]
  destination_cidr_block    = var.destination_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}