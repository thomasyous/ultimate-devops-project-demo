# CREATED AFTER THE S3 AND THE DYNAMODB WAS SET UP! 
# BACKEND REQUIRES STATIC NAMES 
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source for the AWS provider
      version = "= 5.90.1"      # Use a stable version of the AWS provider
    }
  }

  backend "s3" {
    bucket         = "terraform.tfstate-opentelemetry"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-locks-opentelemetry" # Optional, for state locking
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region # AWS provider configuration
}