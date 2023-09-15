data "aws_ssoadmin_instances" "main" { }

resource "aws_organizations_account" "staging" {
  name = "Staging"
  email = "koushik+aws@abbey.io"
}

resource "aws_organizations_account" "production" {
  name = "Production"
  email = "koushik+aws_test_prod@abbey.io"
}

resource "aws_identitystore_group" "r_and_d" {
  description       = null
  display_name      = "R&D"
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
}

resource "aws_identitystore_group" "prod_access" {
  description       = null
  display_name      = "Prod Access"
  identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "read_only_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "ec2_full_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.compute_full_access.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "s3_full_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.compute_full_access.arn
}

resource "aws_ssoadmin_permission_set" "read_only" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ReadOnlyAccess"
}

resource "aws_ssoadmin_permission_set" "compute_full_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ComputeFullAccess"
}

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