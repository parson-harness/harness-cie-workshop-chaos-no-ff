provider "aws" {
  region = "us-east-1"
}

data "aws_eks_cluster" "eks_cluster" {
  name = "harness-eks-parson"
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = "harness-eks-parson"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
}

resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.namespace-name
  }
}


output "name" {
  value = kubernetes_namespace.ns.metadata[0].name
}

variable "namespace-name" {
  type = string
}