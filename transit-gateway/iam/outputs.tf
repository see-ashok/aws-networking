# -- iam/outputs.tf -- #

output "sqs_ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_sqs_instance_profile.name
}