terraform {
  backend "s3" {
    bucket = "webkulterraformtfstate"
    key    = "terraform/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
