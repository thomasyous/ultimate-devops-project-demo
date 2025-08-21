
resource "aws_s3_bucket" "demo-terraform-eks-state-bucket" {
  bucket = "demo-terraform-eks-state-bucket-20-08-2025-05-27"

  lifecycle {
    prevent_destroy = false
  }
}


resource "aws_dynamodb_table" "terraform-eks-state-locks" {
  name           = "terraform-eks-state-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}