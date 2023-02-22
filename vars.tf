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

variable "asg_min_size" {
  description = "Minimal size of autoscaling group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of autoscaling group"
  type        = number
  default     = 3
}
