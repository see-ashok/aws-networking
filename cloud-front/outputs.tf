
# -- root/outputs.tf -- # 

output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "bucket_name_failover" {
  value = module.s3Failover.bucket_name
}

output "bucket_regional_domain_name_failover" {
  value = module.s3Failover.bucket_regional_domain_name
}
output "bucket_name_primary" {
  value = module.s3Primary.bucket_name
}

output "bucket_regional_domain_name_primary" {
  value = module.s3Primary.bucket_regional_domain_name
}
/*
output "ec2_public_ipv4_dns" {
  value = module.vpc_a_ec2_public.public_ip4_dns
}*/

output "cloudfront_domain_name" {
  value = module.cloud-front.cloudfront_domain_name
}