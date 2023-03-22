# -- compute/ec2.tf) -- #


data "aws_ami" "amazon_linux2ami" {
  most_recent = true
  owners      = ["amazon"] 
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_security_group" "security_group" {
   vpc_id = var.vpc_id
   ingress {
    description      = "TLS from VPC"
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


resource "aws_instance" "ec2" {

  ami           = data.aws_ami.amazon_linux2ami.id
  instance_type = "t3.micro" #var.instance_type
  subnet_id  = var.subnet_id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  
  tags = {
    Name = var.ec2_name

  }
  root_block_device {
    volume_size = "10"
  }

}
