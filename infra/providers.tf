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
    bucket         = "terraform-state-main2"
    key            = "lambda/terraform.tfstate" 
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-main2"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "Project" = "PaymentService"
      "Owner"   = "mazzotti.app"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
