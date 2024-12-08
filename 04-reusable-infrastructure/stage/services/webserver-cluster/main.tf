terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["/Users/topo/.aws/credentials"]
  profile = "terraform"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "terraform-state-stage-777"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}