module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.8.0"

  name               = "meu-cluster-eks"
  kubernetes_version         = "1.34"
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      iam_role_additional_policies = {
        worker     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        cni        = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        ecr        = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        cloudwatch = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      }
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "null_resource" "install_eks_addons" {
  depends_on = [
    module.eks,
  ]

 provisioner "local-exec" {
  command = "bash addons.sh ${module.eks.cluster_name} ${var.region}"
}
}

