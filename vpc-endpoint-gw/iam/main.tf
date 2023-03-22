# --iam/main.tf -- #

resource "aws_iam_policy" "ec2_s3_policy" {
  name = "ec2_policy"
  path = "/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*",
            "s3-object-lambda:*"
          ],
          "Resource" : "*"
        },
      ]
    }
  )
}

resource "aws_iam_role" "ec2_s3_role" {

  name = "ec2_role"
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
    }
  )

}


resource "aws_iam_policy_attachment" "ec2_s3_role_policy" {
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
  roles      = [aws_iam_role.ec2_s3_role.name]
  name       = "ec2-iam-s3-policy-att"
}

resource "aws_iam_instance_profile" "ec2_s3_instance_profile" {
  name = "ec2-iam-s3-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}