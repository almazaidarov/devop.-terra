resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "terraform_class"
    managed_by = "https://github.com/almazaidarov/devop.-terra"
  }
}



resource "aws_key_pair" "terraform_class2" {
  key_name   = "terraform_class2"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "terraform_class1" {
  key_name   = "terraform_class1"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
  bucket_prefix = "terraform-class"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}