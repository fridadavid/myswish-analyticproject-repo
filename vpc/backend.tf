/* terraform {

  backend "s3" {

    # Replace this with your bucket name!

    bucket         = "swish-s3"
    key            = "terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!

    dynamodb_table = "swish_dynamodb"
    encrypt        = false
  }
} */