gitlabUrl: https://gitlab.com
runnerToken: "glrt-12345789"

rbac:
  create: true
  clusterWideAccess: false
  serviceAccountAnnotations:
    "eks.amazonaws.com/role-arn": "${role_arn}"
  rules:
    - resources: ["configmaps", "events", "pods", "pods/attach", "pods/exec", "secrets", "services"]
      verbs: ["get", "list", "watch", "create", "patch", "update", "delete"]
    - apiGroups: [""]
      resources: ["pods/exec"]
      verbs: ["create", "patch", "delete"]
    - apiGroups: [""]
      resources: ["pods/log"]
      verbs: ["get"]

runners:
  config: |
    concurrent = 10
    [[runners]]
      [runners.kubernetes]
        namespace = "{{.Release.Namespace}}"
        image = "alpine"
        privileged = false
        service_account = "gitlab-ci-runners-gitlab-runner" # Service account for runner
        service_account_overwrite_allowed = "gitlab-ci-runners-app" # Service account for ci/cd jobs