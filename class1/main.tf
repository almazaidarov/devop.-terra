resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terraform_class"
    managed_by = "https://github.com/almazaidarov/devop.-terra"
  }
}

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

resource "aws_key_pair" "terraform_class" {
  key_name   = "terraform_class"
  public_key = file("~/.ssh/id_rsa.pub")
}

