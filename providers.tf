terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.58.0, !=4.60.0, <=4.61.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  alias      = "Virginia"
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}
