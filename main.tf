locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  policies_path = "${local.project_path}/policies"
}

resource "abbey_grant_kit" "group_membership_grant" {
  name = "group_membership_grant"
  description = <<-EOT
    Grants membership for an IAM Identity Center managed user
    to an Identity Center managed group.
    This Grant Kit uses a single-step Grant Workflow that requires only a single reviewer
    from a list of reviewers to approve access.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"] #CHANGEME
        }
      }
    ]
  }

  output = {
    location = "${local.project_path}/access.tf"
    append = <<-EOT
      resource "aws_identitystore_group_membership" "user_{{ .user.aws_identitystore.id }}_group_${aws_identitystore_group.prod_access.group_id}" {
        member_id = "{{ .user.aws_identitystore.id }}"
        group_id = aws_identitystore_group.prod_access.group_id
        identity_store_id = data.aws_ssoadmin_instances.main.identity_store_ids[0]
      }
    EOT
  }
}
