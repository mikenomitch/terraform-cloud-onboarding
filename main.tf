provider "aws" {
  version = "3.0.0"
}

resource "random_id" "random" {
  keepers = {
    uuid = "${uuid()}"
  }

  byte_length = 8
}

resource "aws_s3_bucket" "b" {
  bucket = "s3-teraform-onboarding-${random_id.random.hex}.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}
