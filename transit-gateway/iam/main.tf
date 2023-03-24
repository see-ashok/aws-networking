# --iam/main.tf -- #

resource "aws_iam_policy" "ec2_sqs_policy" {
  name = "ec2-iam-sqs-policy"
  path = "/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "sqs:*"
          ],
          "Effect" : "Allow",
          "Resource" : "*"
        },
      ]
    }
  )
}

resource "aws_iam_role" "ec2_sqs_role" {
  name = "ec2-iam-sqs-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_sqs_role_policy" {
  policy_arn = aws_iam_policy.ec2_sqs_policy.arn
  roles      = [aws_iam_role.ec2_sqs_role.name]
  name       = "ec2-iam-sqs-policy-att"
}

resource "aws_iam_instance_profile" "ec2_sqs_instance_profile" {
  name = "ec2-iam-sqs-instance-profile"
  role = aws_iam_role.ec2_sqs_role.name
}