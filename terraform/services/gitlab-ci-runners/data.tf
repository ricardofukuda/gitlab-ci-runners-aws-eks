data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "eks" {
  name = "eks-${var.tags.Environment}"
}

data "template_file" "values" {
  template = file("${path.module}/config/values.yaml.tpl")

  vars = {
    aws_account_id = local.account_id
    docker_image = "${aws_ecr_repository.ecr.repository_url}:latest"
    role_arn = module.role.iam_role_arn
  }
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    sid    = lower("auth")
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid    = lower("pull")
    effect = "Allow"

    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer"
    ]
    
    resources = [
      aws_ecr_repository.ecr.arn
    ]
  }

  statement {
    sid    = lower("push")
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = [
      aws_ecr_repository.ecr_app.arn
    ]
  }
}