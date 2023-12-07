terraform {
  backend "http" {
    address        = "https://api.abbey.io/terraform-http-backend"
    lock_address   = "https://api.abbey.io/terraform-http-backend/lock"
    unlock_address = "https://api.abbey.io/terraform-http-backend/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }

 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }

    abbey = {
      source = "abbeylabs/abbey"
      version = "0.2.6"
    }   
 }
}
 
provider "aws" {
 region = "us-east-1"
}

provider "abbey" {
  bearer_auth = var.abbey_token
}
