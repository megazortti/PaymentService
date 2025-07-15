terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "terraform-state-main2"  # seu bucket S3 do state
    key            = "lambda/terraform.tfstate"  # caminho do state
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-main2"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
