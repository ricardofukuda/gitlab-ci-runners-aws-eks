resource "helm_release" "gitlab_ci_runners" {
  name       = "gitlab-ci-runners"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab-runner"
  version    = "0.62.0"

  namespace = local.namespace
  create_namespace = true

  values = [
    data.template_file.values.rendered
  ]
}