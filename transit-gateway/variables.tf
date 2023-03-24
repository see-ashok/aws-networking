# -- variables.tf -- 

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_cidr_a" {
  default = "10.1.0.0/16"
}


variable "vpc_cidr_b" {
  default = "10.2.0.0/16"
}

variable "vpc_cidr_c" {
  default = "10.3.0.0/16"
}
