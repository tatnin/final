terraform {
  backend "s3" {
    bucket = "nt-s3"
    key    = "final/state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "nt-ecr" {
  name                 = "nt-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
