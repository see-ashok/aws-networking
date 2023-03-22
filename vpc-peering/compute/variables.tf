# -- compute/variables.tf -- #

variable "subnet_id" {}

variable "ec2_name" {}

# Security Groups
variable "sg_ports" {
  type    = list(number)
  default = [0]
}


variable "vpc_id" {
  
}



