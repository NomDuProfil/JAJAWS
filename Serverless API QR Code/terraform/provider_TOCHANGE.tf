terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.19.0"
        }
    }
    backend "s3" {
        encrypt = true
        bucket  = "TO_CHANGE"
        key     = "TO_CHANGE"
        region  = "TO_CHANGE"
    }
}