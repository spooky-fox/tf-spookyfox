terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    region         = "us-west-2"
    bucket         = "sf-uw2-dev"
    key            = "eks-cluster/terraform.tfstate"
    dynamodb_table = "sf-uw2-dev-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}