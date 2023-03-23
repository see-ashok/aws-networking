# -- vpc_endpoint_if/main.tf -- #

resource "aws_security_group" "security_group" {
   vpc_id = var.vpc_id
   ingress {
    description      = "HTTPS for Endpoint Interface "
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_endpoint" "sqs_vpc_ep_interface" {
  vpc_id = var.vpc_id
  vpc_endpoint_type = "Interface"
  service_name    = "com.amazonaws.${var.aws_region}.sqs"
  subnet_ids = [var.subnet_ids]
  private_dns_enabled = true
  security_group_ids = [aws_security_group.security_group.id]


}