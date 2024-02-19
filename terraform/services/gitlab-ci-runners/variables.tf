variable "tags" {
  type = map(string)

  default = {
    Service = "gitlab-ci-runners"
    Terraform = true
    Environment = "infra"
  }
}