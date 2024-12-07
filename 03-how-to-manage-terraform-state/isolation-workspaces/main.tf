provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["/Users/topo/.aws/credentials"]
  profile = "terraform"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-tutorial-chung"
    key            = "workspaces-example/terraform.tfstate"
    region         = "us-east-2"

    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true

    shared_credentials_file = "/Users/topo/.aws/credentials"
    profile                 = "terraform"
  }
}