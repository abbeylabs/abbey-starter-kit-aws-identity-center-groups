# Read-Only Policy
resource "aws_ssoadmin_managed_policy_attachment" "read_only_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.read_only.arn
}

resource "aws_ssoadmin_permission_set" "read_only" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ReadOnlyAccess"
}


# Compute Full Access Policy
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

resource "aws_ssoadmin_permission_set" "compute_full_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ComputeFullAccess"
}
