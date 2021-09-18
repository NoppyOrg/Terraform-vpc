

module "vpc" {
  source     = "../../modules/vpc"
  create_igw = false

  vpcflowlogsbucket = "arn:aws:s3:::nobuyuf-tforg-test01-vpcflowlogs"
}