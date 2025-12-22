resource "aws_iam_user" "lb" {
  name = "terraform_class"
  path = "/system/"

  tags = {
    Name = "terraform_class"
    managed_by = "https://github.com/almazaidarov/devop.-terra"
  }
}

resource "aws_iam_group" "terraform_class" {
  name = "terraform_class"
}

  resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.lb.name
  ]

  group = aws_iam_group.terraform_class.name
}


resource "aws_iam_policy" "policy" {
  name        = "admin_policy"
  path        = "/"
  description = "My test policy"

  
  policy = jsonencode(
    {
        "Version": "2012-10-17",
        "Statement": [
            {
              "Effect": "Allow",
              "Action": "*",
              "Resource": "*"
            }
        ]
    }
)
}
  
