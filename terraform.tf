terraform {
  required_version = "~> v1.15.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }


  backend "s3" {
    bucket       = "sagar-terraform-state-locking-tutorial-second"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }

}

provider "aws" {
  region = var.aws_region
}
