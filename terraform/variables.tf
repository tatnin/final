variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}
variable vpc_cidr_block {}
variable environment {
  default = "dev"
}

locals {
  cluster_name = "nt-eks-cluster-${var.environment}"
}
