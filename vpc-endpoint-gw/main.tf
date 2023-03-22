#-- root/main.tf -- # 

module "vpc_b" {
  source           = "./networking"
  vpc_cidr         = var.vpc_cidr_b #"10.1.0.0/16"
  private_sn_count = 1
  public_sn_count  = 1
  name             = "VPC-B"
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
module "iam_ec2_s3" {
  source = "./iam"

}


module "vpc_b_ec2_bastion" {
  source    = "./compute"
  vpc_id    = module.vpc_b.vpc_id
  subnet_id = module.vpc_b.public_subnet_id[0]
  ec2_name  = "Bastion Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  # below is for attachiong s3 instance role  
  #instance_profile = aws_iam_instance_profile.ec2_profile.name
  instance_profile = module.iam_ec2_s3.s3_ec2_instance_profile_name
}

module "vpc_b_ec2_private_host" {
  source    = "./compute"
  vpc_id    = module.vpc_b.vpc_id
  subnet_id = module.vpc_b.private_subnet_id[0]
  ec2_name  = "Private Host"
  key_name  = aws_key_pair.tf_key_pair.key_name
  # below is for attachiong s3 instance role  
  #instance_profile = aws_iam_instance_profile.ec2_profile.name
  instance_profile = module.iam_ec2_s3.s3_ec2_instance_profile_name

}


module "s3" {
  source      = "./object"
  bucket_name = "my-vpc-gw-ep-test"
}
#VPC Endpoint Gateway for s3 
module "vpc_ep_gw" {
  source         = "./vpc_endpoint_gw"
  aws_region = var.aws_region
  vpc_id         = module.vpc_b.vpc_id
  route_table_id = module.vpc_b.private_route_table_id
} 

