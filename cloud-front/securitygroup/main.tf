# -- securitygroup/main.tf -- #


resource "aws_security_group" "security_group" {
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.sg_type_protocol
    iterator = port # Without this port will be replaced by ingress
    content {
      from_port   = port.value # ingress.value
      to_port     = port.value
      protocol    = port.key
      cidr_blocks = [var.cidr_blocks]
    }
  }
  dynamic "egress" {
    for_each = var.sg_type_protocol
    iterator = port # Without this port will be replaced by ingress
    content {
      from_port   = port.value # ingress.value
      to_port     = port.value
      protocol    = port.key
      cidr_blocks = [var.cidr_blocks]
    }
  }
}