terraform {
  backend "s3" {
    bucket         = "ajaytest0987"
    key            = "Day-5-remote-backend-dynamodb-lock/terraform.tfstate"
    region         = "us-east-1"      
    dynamodb_table = "AjayDynamoDB"
    # encrypt      = true
  }
}
