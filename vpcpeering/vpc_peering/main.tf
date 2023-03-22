# -- vpc_peering/main.tf -- # 
resource "aws_vpc_peering_connection" "vpc_to_vpc" {
  peer_vpc_id = var.peer_vpc_id 
  vpc_id = var.origin_vpc_id 
  auto_accept = true
    tags = {
    Name = var.vpc_peering_name
  }
}

