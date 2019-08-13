provider "aws" {
  region     = "us-east-1"
  access_key = var.credentials.access_key
  secret_key = var.credentials.secret_key
}

