data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (official Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}





resource "aws_security_group" "wordpress-terraform" {
  name        = "wordpress-terraform"
  description = "Allow TLS inbound traffic and all outbound traffic"
}

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
  source = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  name                      = "example-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 3
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets






  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t3.micro"
  ebs_optimized     = false
  enable_monitoring = false

}


module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name   = "my-alb"

  
  vpc_id = module.vpc.vpc_id

  
  subnets = module.vpc.public_subnets

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "ex-instance"
      }
    }
  }

  target_groups = {
    ex-instance = {
<<<<<<< HEAD
      name_prefix = "tg"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
=======
      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
      target_id   = "i-0f6d38a07d50d080f"
>>>>>>> b6f6e7e (WIP: local terraform changes)
    }
  }
}
