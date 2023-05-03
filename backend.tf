terraform {
  backend "s3" {
    bucket = "mydev-tf-state-bucket-rahul"
    key = "main"
    region = "us-east-1"
    //dynamodb_table = "my-dyanamo-db-table"
  }
}
