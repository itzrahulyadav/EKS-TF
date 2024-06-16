resource "aws_iam_role" "eks" {
  name = "${local.env}-${local.eks_name}-eks-cluster"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "eks" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_eks_cluster" "eks" {
  name     = "${local.env}-${local.eks_name}"
  role_arn = aws_iam_role.eks.arn
  version = local.eks_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    
    subnet_ids = [
    aws_subnet.private_zone1.id,
    aws_subnet.private_zone2.id
    ]
  }
  
  access_config {
      authentication_mode = "API"
      bootstrap_cluster_creator_admin_permissions = true
  }
  
  depends_on = [aws_iam_role_policy_attachment.eks]
}

