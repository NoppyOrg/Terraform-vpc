



variable "vpcname" {
  description = "Name to used on the VPC."
  type        = string
  default     = "SampleVpc"
}


variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created."
  type        = bool
}

variable "vpcflowlogsbucket" {
  description = "S3 bucket ARN for VPC Flow Logs."
  type        = string
}