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
