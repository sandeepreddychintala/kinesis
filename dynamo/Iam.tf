resource "aws_iam_role" "test_role" {
  name = "del-adm-test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"

      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}


resource "aws_iam_policy" "policy" {
  name        = "del-adm-test_policy"
  path        = "/"
  description = "My test policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"             
            ],
            "Resource": "${aws_dynamodb_table.basic-dynamodb-table.arn}"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "kinesis:*",
            "Resource": "${aws_kinesis_stream.test_stream.arn}"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "${aws_s3_bucket.main.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.test_role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
