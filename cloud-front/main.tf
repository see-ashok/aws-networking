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


module "security_group_a" {
  source      = "./securitygroup"
  vpc_id      = module.vpc_a.vpc_id
  cidr_blocks = "0.0.0.0/0"
  sg_type_protocol = {
    all = 0

  }
  sg_egrees_ports = [0]

}

module "s3Primary" {
  source      = "./object"
  bucket_name = "my-great-bucket-testy"
  source_file = "object/index.html"
}

module "s3Failover" {
  source      = "./object"
  bucket_name = "my-great-bucket-testy-f"
  source_file = "object/index_f.html"
}

module "cloud-front" {
  source         = "./cloud-front"
  s3_primary = module.s3Primary.bucket_id
  s3_failover = module.s3Failover.bucket_id
  #s3_domain_name = module.s3Primary.bucket_regional_domain_name
  #s3_domain_name = module.s3.bucket_name
  #ec2_domain_name = module.vpc_a_ec2_public.public_ip4_dns
  depends_on = [
    module.s3Primary,
    module.s3Failover
   # module.vpc_a_ec2_public
  ]
}

/*
module "cdn-oac-bucket-policy-primary" {
  source = "./cdn-oac"
  bucket_id = module.s3Primary.bucket_id
  cloudfront_arn = module.cloud-front.cloudfront_arn
  bucket_arn = module.s3Primary.bucket_arn
}*/

module "cdn-oac-bucket-policy-failover" {
  source = "./cdn-oac"
  bucket_id = module.s3Failover.bucket_id
  cloudfront_arn = module.cloud-front.cloudfront_arn
  bucket_arn = module.s3Failover.bucket_arn
}