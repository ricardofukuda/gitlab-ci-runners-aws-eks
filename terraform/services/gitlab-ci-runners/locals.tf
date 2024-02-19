locals{
  account_id = data.aws_caller_identity.current.account_id
  serviceaccount_app = lower("${var.tags.Service}-app")
  namespace = "gitlab-ci-runners"
  namespaces_apps = ["hml", "prod", "dev"]
}