provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "terraform.tfstate-opentelemetry"
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "Terraform OpenTelemetry State"
  }
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ------------------------- DynamoDB table ------------------------- #

resource "aws_dynamodb_table" "tfstate_locks" {
  name         = "tfstate-locks-opentelemetry"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"

  tags = {
    Name        = "Terraform OpenTelemetry Lock Table"
  }
}