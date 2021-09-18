

####################################################
# VPC
####################################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpcname
  }
}

####################################################
# IGW
####################################################
resource "aws_internet_gateway" "this" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.vpcname}-igw"
  }
}

####################################################
# VPC Flow logs
####################################################
resource "aws_flow_log" "this" {
  log_destination      = var.vpcflowlogsbucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this.id
  tags = {
    Name = "${var.vpcname}-vpc-flow-log"
  }
}