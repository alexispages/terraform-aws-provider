variable "ami_name" {
  description = "AMI name to filter"
  type        = string
  default     = "amzn2-ami-kernel-5.*-hvm-*-x86_64-gp2"
}

variable "instance_type" {
  description = "Type of instance to use"
  type        = string
  default     = "t3.micro"
}
