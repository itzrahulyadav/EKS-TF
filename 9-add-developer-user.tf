resource "aws_iam_user" "developer" {
  name = "developer"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "developer_eks" {
    name = "AmazonEKSDeveloperPolicy"

    policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"eks:DescribeCluster",
				"eks:ListClusters"
			],
			"Resource": "*"
		}
	]
})
}