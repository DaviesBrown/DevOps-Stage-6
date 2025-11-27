terraform {
  backend "s3" {
    bucket = "todo-terraform-bucket"
    key    = "tf/tfstate"
    region = "us-east-1"

    # required for S3-compatible backends
    use_path_style            = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true

    endpoints = {
      s3 = "https://us-southeast-1.linodeobjects.com"
    }
  }
}
