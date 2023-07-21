provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = "Test"
      Project     = "Test"
    }
  }

}