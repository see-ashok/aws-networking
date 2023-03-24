# -- transit-gw/variables.tf # 

variable "vpc_ids" {
  type = list(any)
}

variable "subnet_ids" {
  type = list(any)
}

