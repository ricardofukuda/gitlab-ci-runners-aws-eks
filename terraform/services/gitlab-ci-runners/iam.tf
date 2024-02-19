module "policy" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-policy?ref=v4.2.0"

  name        = lower("${var.tags.Service}-${var.tags.Environment}")
  path        = "/"
  policy      = data.aws_iam_policy_document.policy_document.json

  tags = var.tags
}

module "role" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam//modules/iam-assumable-role-with-oidc?ref=v4.4.0"

  create_role = true

  role_name                     = lower("${var.tags.Service}-${var.tags.Environment}")
  provider_url                  = data.aws_eks_cluster.eks.identity[0]["oidc"][0]["issuer"]
  oidc_fully_qualified_subjects = [
    lower("system:serviceaccount:${var.tags.Service}:${var.tags.Service}-app"),
    lower("system:serviceaccount:${var.tags.Service}:${var.tags.Service}-gitlab-runner")
  ]
  role_policy_arns              = [module.policy.arn]

  tags = var.tags
}