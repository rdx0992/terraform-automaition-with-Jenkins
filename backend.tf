terraform {
  backend "s3" {
    bucket = "my-s3-buket-terraform"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dyanamo-db-table"
  }
}
