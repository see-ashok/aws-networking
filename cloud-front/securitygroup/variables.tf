# securitygroup/variables.tf -- # 

variable "sg_type_protocol" {
  type = map(number)

}

variable "cidr_blocks" {
  type = string


}


variable "sg_egrees_ports" {
  type = list(any)
}

variable "vpc_id" {

}