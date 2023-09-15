resource "abbey_grant_kit" "group_membership_grant" {
  name = "group_membership_grant"
  description = <<-EOT
    Grants membership for an IAM Identity Center managed user
    to an Identity Center managed group.
    This Grant Kit uses a single-step Grant Workflow that requires only a single reviewer
    from a list of reviewers to approve access.    
  EOT

  workflow = {
    steps = [ {
      reviewers = {
        one_of = ["alice@example.com"] #CHANGEME
      }
    } ]
  }

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "github://replace-me-with-organization/replace-me-with-repo/access.tf" #CHANGEME
    append = <<-EOT
      resource "aws_identitystore_group_membership" "user_{{ .data.system.abbey.identities.aws_member.id }}_group_${data.aws_iam_group.prod_access.group_name}" {
        member_id = "{{ .data.system.abbey.identities.aws_member.id }}"
        group_id = ["${aws_identitystore_group.prod_access.group_id}"]
      }
    EOT
  }
}

resource "abbey_identity" "user_1" {
  abbey_account = "replace-me@example.com" #CHANGEME
  source = "aws_iam"
  metadata = jsonencode(
    {
      id = "ReplaceWithAWSIdentityCenterUserId" #CHANGEME
    }
  )
}
