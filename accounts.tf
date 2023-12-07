resource "aws_organizations_account" "staging" {
  name = "Staging"
  email = "staging_owner@example.com" #CHANGEME
}

resource "aws_organizations_account" "production" {
  name = "Production"
  email = "production_owner@example.com" #CHANGEME
}
