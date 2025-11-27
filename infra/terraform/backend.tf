terraform {
  backend "s3" {
    bucket = "todo-terraform-bucket"
    key    = "tf/tfstate"
    region = "us-southeast-1"
    access_key = "2P0YIANJ2BF3SSP0N1P5"
    secret_key = "0KTXAmMh1QBnqbvKgWbrEHqFerV7usEDHnKDRyc0"

    # required for S3-compatible backends
    use_path_style            = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum = true

    endpoints = {
      s3 = "https://us-southeast-1.linodeobjects.com"
    }
  }
}
