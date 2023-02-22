variable "ami_name" {
  description = "AMI name filter"
  type        = string
  default     = "amzn2-ami-kernel-5.*-x86_64-gp2"
}

variable "instance_type" {
  description = "Type of instance to use"
  type        = string
  default     = "t3.micro"
}
