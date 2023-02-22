terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  shared_credentials_files = ["/home/apages/.aws/credentials"]
  profile = "student_10"
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

resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.my_ami.id  # Linux EC2 AMI
  instance_type = var.instance_type
  key_name      = "aws-terraform"

  subnet_id = data.aws_subnet.my_subnet.id  # Public subnet ID

  tags = {
    Name = "Plage-EC2"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "aws-terraform"
  public_key = file("~/.ssh/aws-terraform.pub")
}

output "public_dns" {
  value = aws_instance.my_instance.public_dns
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}