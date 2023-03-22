
# -- root/outputs.tf -- # 

output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  value = module.vpc_b.vpc_id
}
