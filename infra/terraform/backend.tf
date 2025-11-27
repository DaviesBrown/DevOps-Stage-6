terraform {
  backend "s3" {
    bucket                      = "your-terraform-state-bucket"
    key                         = "tf/tfstate"
    region                      = "us-east-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
    endpoint                    = "us-southeast-1.linodeobjects.com"
  }
}
