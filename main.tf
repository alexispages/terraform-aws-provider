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

data "aws_key_pair" "my_key_pair" {
  key_name = "aws-terraform"
}

resource "aws_launch_configuration" "plage_launch_configuration" {
  name                 = "plage-launch-configuration-${terraform.workspace}"
  image_id             = data.aws_ami.my_ami.id
  instance_type        = var.instance_type
  key_name             = data.aws_key_pair.my_key_pair.key_name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  name                      = "plage-asg-${terraform.workspace}"
  launch_configuration      = aws_launch_configuration.plage_launch_configuration.id
  vpc_zone_identifier       = [data.aws_subnet.my_subnet.id]
  desired_capacity          = var.asg_desired_capacity
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  termination_policies      = ["OldestInstance"]
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
