terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }

    abbey = {
      source = "abbeylabs/abbey"
      version = "0.2.4"
    }   
 }
}
 
provider "aws" {
 region = "us-east-1"
}

provider "abbey" {
  bearer_auth = var.abbey_token
}