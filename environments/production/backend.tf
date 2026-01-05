terraform {
  backend "s3" {
    bucket = "webkulterraformtfstate"
    key    = "production/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
