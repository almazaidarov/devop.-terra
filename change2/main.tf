 data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]  # Canonical (official Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}





# resource "aws_security_group" "wordpress-terraform" {
#   name        = "wordpress-terraform"
#   description = "Allow TLS inbound traffic and all outbound traffic"
# }

# resource "aws_key_pair" "terraform_class" {
#   key_name   = "terraform_class"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# resource "aws_instance" "web" {
#   count                           = 5
#   ami                             = data.aws_ami.ubuntu.id
#   instance_type                   = "t3.micro"
#   associate_public_ip_address     = true
#   availability_zone               = "us-east-1a"
#   key_name                        = aws_key_pair.terraform_class.key_name
#   user_data                       = file("wordpress.sh")
#   vpc_security_group_ids          = [aws_security_group.wordpress-terraform.id]
# } 


# resource "aws_instance" "web2" {
#   ami                             = data.aws_ami.ubuntu.id
#   instance_type                   = "t3.micro" 
# }




module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = false
  enable_vpn_gateway = false


}




module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  name = "example-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 3
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]
  


  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t3.micro"
  ebs_optimized     = false
  enable_monitoring = false
}