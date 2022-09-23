variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}
variable vpc_cidr_block {}
variable environment {
  default = "dev"
}
resource "random_string" "suffix" {
  length = 8
  special = false
}

locals {
  cluster_name = "nt-eks-${random_string.suffix.result}"
}
