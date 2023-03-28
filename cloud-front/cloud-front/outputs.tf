# -- cloud-front/outputs.tf -- # 

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.my_distrib.domain_name
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.my_distrib.arn
}