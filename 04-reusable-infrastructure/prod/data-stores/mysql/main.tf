provider "aws" {
  region                   = "us-east-2"
  shared_credentials_files = ["/Users/topo/.aws/credentials"]
  profile                  = "terraform"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"

  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-tutorial-chung"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true

    shared_credentials_file = "/Users/topo/.aws/credentials"
    profile                 = "terraform"
  }
}