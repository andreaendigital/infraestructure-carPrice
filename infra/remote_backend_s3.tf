terraform {
  backend "s3" {
    bucket = "carprice-terraform-state-1762104794"
    key    = "carprice/terraform.tfstate"
    region = "eu-central-1"
  }
}