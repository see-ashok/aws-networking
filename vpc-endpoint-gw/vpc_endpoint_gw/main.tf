# -- vpc_endpoint_gw/main.tf -- #


resource "aws_vpc_endpoint" "vpc_endpoint_gw" {
  vpc_id = var.vpc_id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = ["${var.route_table_id}"]
}

