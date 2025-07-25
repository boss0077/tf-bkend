terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

##this tf file will create 2 resources s3 and dynamoDB 
#where it helps in remote remote backend and state locking 

provider "aws" {
  region = "us-east-1"
}


module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "trfm-bkend"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true

  tags = {
    Name        = "My S3 Bucket"
    Environment = "test"
  }

}

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "state-lock"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = {
    Name        = "State Lock Table"
    Environment = "test"
  }

}