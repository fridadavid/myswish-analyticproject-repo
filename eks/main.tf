module "eks" {
  source                 = "../modules/eks"
  cluster-name           = var.cluster-name
  eks_node_instance_type = var.eks_node_instance_type
  eks_tag_environment    = var.eks_tag_environment
  iam_role_name          = var.iam_role_name
  iam_role_node_name     = var.iam_role_node_name
  sg_name                = var.sg_name
  node_group_name        = var.node_group_name
  node_name              = var.node_name
  key_pair_name          = var.key_pair_name
}