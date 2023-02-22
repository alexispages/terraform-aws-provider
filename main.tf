terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_ami" "my_ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

data "aws_subnet" "my_subnet" {
  filter {
    name   = "tag:defaultSubnet"
    values = ["true"]
  }
}

resource "aws_launch_configuration" "plage_launch_configuration" {
  name                 = "plage-launch-configuration"
  image_id             = data.aws_ami.my_ami.id
  instance_type        = var.instance_type
  key_name             = "aws-terraform"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "aws-terraform"
  public_key = file("~/.ssh/aws-terraform.pub")
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  name                      = "plage-autoscaling-group"
  launch_configuration      = aws_launch_configuration.plage_launch_configuration.id
  vpc_zone_identifier       = [data.aws_subnet.my_subnet.id]
  desired_capacity          = 1
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  termination_policies      = ["OldestInstance"]
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
