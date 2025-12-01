terraform {
  backend "s3" {
    bucket       = "s3nativelocksetup"
    key          = "backend/terraform.tfstate"
    profile      = "default"
    region       = "us-east-1"
    use_lockfile = true
  }
}