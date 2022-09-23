provider "kubernetes" {
  host = data.aws_eks_cluster.nt-cluster.endpoint
  token = data.aws_eks_cluster_auth.nt-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.nt-cluster.certificate_authority.0.data)
}
data "aws_eks_cluster" "nt-cluster" {
  name = module.nt-eks-cluster.cluster_id
}

data "aws_eks_cluster_auth" "nt-cluster" {
  name = module.nt-eks-cluster.cluster_id
}

module "nt-eks-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name = "nt-eks-cluster-${var.environment}"
  cluster_version = "1.21"

  subnet_ids = module.nt-vpc.private_subnets
  vpc_id = module.nt-vpc.vpc_id

  tags = {
    environment = var.environment
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = ["t2.micro"]
    }
  }

}
