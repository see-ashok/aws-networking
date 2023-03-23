# -- sqs/main.tf -- #

resource "aws_sqs_queue" "sqs" {
  name = "SQS-Queue-NW"
  
}