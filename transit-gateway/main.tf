#-- root/main.tf -- # 

module "vpc_a" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cidr_a #"10.1.0.0/16"
  private_sn_count = 1
  public_sn_count  = 1
  name             = "VPC-A"
  public_cidrs     = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr_a, 8, i)]
  private_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr_a, 8, i)]
}


module "vpc_b" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cidr_b #"10.2.0.0/16"
  private_sn_count = 1
  public_sn_count  = 1
  name             = "VPC-B"
  public_cidrs     = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr_b, 8, i)]
  private_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr_b, 8, i)]
}

module "vpc_c" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cidr_c #"10.3.0.0/16"
  private_sn_count = 1
  public_sn_count  = 1
  name             = "VPC-C"
  public_cidrs     = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr_c, 8, i)]
  private_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr_c, 8, i)]
}

resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "tf_key_pair" {
  key_name   = "Demoss"
  public_key = tls_private_key.tls_key.public_key_openssh
  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.tls_key.private_key_pem}' > myKey.pem"
  }
}

module "vpc_a_ec2_bastion" {
  source    = "./compute"
  vpc_id    = module.vpc_a.vpc_id
  subnet_id = module.vpc_a.public_subnet_id[0]
  ec2_name  = "Bastion Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  #instance_profile = module.iam_sqs.sqs_ec2_instance_profile_name
}

module "vpc_a_ec2_private_host" {
  source    = "./compute"
  vpc_id    = module.vpc_a.vpc_id
  subnet_id = module.vpc_a.private_subnet_id[0]
  ec2_name  = "Private Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  #instance_profile = module.iam_sqs.sqs_ec2_instance_profile_name

}

module "vpc_b_ec2_bastion" {
  source    = "./compute"
  vpc_id    = module.vpc_b.vpc_id
  subnet_id = module.vpc_b.public_subnet_id[0]
  ec2_name  = "Bastion Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
}

module "vpc_b_ec2_private_host" {
  source    = "./compute"
  vpc_id    = module.vpc_b.vpc_id
  subnet_id = module.vpc_b.private_subnet_id[0]
  ec2_name  = "Private Host"
  key_name  = aws_key_pair.tf_key_pair.key_name

}

module "vpc_c_ec2_bastion" {
  source    = "./compute"
  vpc_id    = module.vpc_c.vpc_id
  subnet_id = module.vpc_c.public_subnet_id[0]
  ec2_name  = "Bastion Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
}

module "vpc_c_ec2_private_host" {
  source    = "./compute"
  vpc_id    = module.vpc_c.vpc_id
  subnet_id = module.vpc_c.private_subnet_id[0]
  ec2_name  = "Private Host"
  key_name  = aws_key_pair.tf_key_pair.key_name

}

module "transit-gateway" {
  source     = "./transit-gw"
  vpc_ids    = [module.vpc_c.vpc_id, module.vpc_b.vpc_id, module.vpc_a.vpc_id]
  subnet_ids = [module.vpc_c.public_subnet_id[0], module.vpc_b.public_subnet_id[0], module.vpc_a.public_subnet_id[0]]

}

module "transit-gw-route" {
  source = "./route"
  gateway_id = module.transit-gateway.gateway_id
  private_route_table_ids = [
    module.vpc_c.private_route_table_id,
    module.vpc_b.private_route_table_id,
    module.vpc_a.private_route_table_id]
  destination_cidr_block = "10.0.0.0/8"
  depends_on = [
    module.transit-gateway
  ]
}
