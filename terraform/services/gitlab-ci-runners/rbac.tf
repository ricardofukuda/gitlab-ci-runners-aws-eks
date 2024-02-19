resource "kubernetes_service_account" "gitlab_runner" {
  metadata {
    name = local.serviceaccount_app
    namespace = local.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = module.role.iam_role_arn
    }
  }
}

resource "kubernetes_namespace" "namespace" {
  for_each = toset(local.namespaces_apps)

  metadata {
    name = each.value
  }
}

resource "kubernetes_role_binding" "role_bind" {
  for_each = toset(local.namespaces_apps)

  metadata {
    name      = local.serviceaccount_app
    namespace = each.value
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = local.serviceaccount_app
  }

  subject {
    kind      = "ServiceAccount"
    name      = local.serviceaccount_app
    namespace = local.namespace
  }

  depends_on = [ kubernetes_namespace.namespace ]
}

resource "kubernetes_role" "role" {
  for_each = toset(local.namespaces_apps)

  metadata {
    name = local.serviceaccount_app
    namespace = each.value
  }

  rule {
    api_groups     = [""]
    resources      = ["pods", "secrets", "serviceaccounts", "services"]
    verbs          = ["get", "list", "create", "patch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "create", "patch"]
  }

  depends_on = [ kubernetes_namespace.namespace ]
}