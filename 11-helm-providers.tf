data "aws_eks_cluster" "eks" {
   name = aws_eks_cluster.eks.name
}

data 