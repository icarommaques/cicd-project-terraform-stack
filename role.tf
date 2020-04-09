resource "aws_iam_role" "ecr_readOnly_role" {
  name = "${var.filename}-dev"

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
      Name = "${var.filename}-dev"
  }
}

resource "aws_iam_instance_profile" "ecr_readOnly_profile" {
  name = "${var.filename}-dev"
  role = "${aws_iam_role.ecr_readOnly_role.name}"
}

resource "aws_iam_role_policy" "ecr_readOnly_policy" {
  name = "${var.filename}-dev"
  role = "${aws_iam_role.ecr_readOnly_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage",
                "ecr:GetLifecyclePolicy",
                "ecr:GetLifecyclePolicyPreview",
                "ecr:ListTagsForResource",
                "ecr:DescribeImageScanFindings"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}