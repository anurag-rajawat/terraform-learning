terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-s3-example"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-example-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  db_name             = "example_db"
  identifier_prefix   = "terraform-learning"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  username            = var.db_username
  password            = var.db_password
}
