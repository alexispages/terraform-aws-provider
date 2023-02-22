# terraform-aws-provider

This Terraform module creates an AWS Linux EC2 instance by default. 

## Usage

```hcl
module "aws" {
    source = "./terraform-aws-provider"
    ami_name = "amzn2-ami-kernel-5.*-x86_64-gp2"
    instance_type = "t3.micro"
    asg_min_size = 1
    asg_max_size = 3
    }
```

## Variable details
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `ami_name` | AMI name filter | `string` | "amzn2-ami-kernel-5.*-x86_64-gp2" | no |
| `instance_type` | Type of instance to use | `string` | "t3.micro" | no |
| `asg_min_size` | Minimal size of autoscaling group | `number` | 1 | no |
| `asg_max_size` | Maximum size of autoscaling group | `number` | 3 | no |

## Outputs

| Name | Description |
|------|-------------|
| `public_dns` | DNS name of the created instance |
| `public_ip` | Public IP address of the created instance |

## Requirements

| Name | Version |
|------|---------|
| `Terraform` | 1.0 or later |
| `Docker` | 23.0.0 or later |

## License

This module is licensed under the MIT License. Please see the LICENSE file for full details.