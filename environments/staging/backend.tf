terraform {
  backend "s3" {
    bucket = "webkulterraformtfstate"
    key    = "staging/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
