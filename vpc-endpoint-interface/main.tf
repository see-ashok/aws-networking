#-- root/main.tf -- # 

module "vpc_a" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cidr_a #"10.1.0.0/16"
  private_sn_count = 1
  public_sn_count  = 1
  name             = "VPC-A"
  public_cidrs     = [for i in range(1, 255, 2) : cidrsubnet(var.vpc_cidr_b, 8, i)]
  private_cidrs    = [for i in range(2, 255, 2) : cidrsubnet(var.vpc_cidr_b, 8, i)]
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

module "iam_sqs" {
  source = "./iam"

}
module "vpc_a_ec2_bastion" {
  source    = "./compute"
  vpc_id    = module.vpc_a.vpc_id
  subnet_id = module.vpc_a.public_subnet_id[0]
  ec2_name  = "Bastion Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  instance_profile = module.iam_sqs.sqs_ec2_instance_profile_name
}

module "vpc_a_ec2_private_host" {
  source    = "./compute"
  vpc_id    = module.vpc_a.vpc_id
  subnet_id = module.vpc_a.private_subnet_id[0]
  ec2_name  = "Private Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  instance_profile = module.iam_sqs.sqs_ec2_instance_profile_name

}

module "sqs" {
  source = "./sqs"
}

module "vpc_ep_if" {
  source = "./vpc_endpoint_if"
  aws_region = var.aws_region
  vpc_id         = module.vpc_a.vpc_id
  subnet_ids   = module.vpc_a.private_subnet_id[0]

}