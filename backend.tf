terraform {
  backend "s3" {
    bucket = "my-s3-buket-rahul"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dyanamo-db-rahul"
  }
}
