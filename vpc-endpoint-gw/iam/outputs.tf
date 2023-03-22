# -- iam/outputs.tf -- #

output "s3_ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_s3_instance_profile.name
}