
resource "aws_ssoadmin_account_assignment" "r_and_d_staging_read_only" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn

  principal_id = aws_identitystore_group.r_and_d.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.staging.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "r_and_d_staging_compute_full_access" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.compute_full_access.arn

  principal_id = aws_identitystore_group.r_and_d.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.staging.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "r_and_d_prod_read_only" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn

  principal_id = aws_identitystore_group.r_and_d.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.production.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "prod_access_prod" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn

  principal_id = aws_identitystore_group.prod_access.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.production.id
  target_type = "AWS_ACCOUNT"
}
