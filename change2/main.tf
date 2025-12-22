data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_security_group" "wordpress-terraform" {
  name        = "wordpress-terraform"
  description = "Allow TLS inbound traffic and all outbound traffic"
}


resource "aws_instance" "web" {
  ami                             = data.aws_ami.ubuntu.id
  instance_type                   = "t3.micro"
  associate_public_ip_address     = true
  availability_zone               = "us-east-1a"
  user_data                       = file("wordpress.sh")
  vpc_security_group_ids          = [aws_security_group.wordpress-terraform.id]
} 




