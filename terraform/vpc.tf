
data "aws_availability_zones" "available" {}

module "nt-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "nt-vpc-${var.environment}"
  cidr = var.vpc_cidr_block

  azs = data.aws_availability_zones.available.names
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    environment = var.environment
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    environment = var.environment
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    environment = var.environment
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

}
