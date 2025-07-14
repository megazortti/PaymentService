terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-main2" # MUDE para um nome único global aqui
  acl    = "private"
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock-main2" # MUDE para um nome único global
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
