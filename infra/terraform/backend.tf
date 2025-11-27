terraform {
  backend "s3" {
    bucket                      = "todo-terraform-bucket"
    key                         = "tf/tfstate"
    region                      = "us-southeast-1"
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    endpoints = {
      s3 = "https://us-southeast-1.linodeobjects.com"
    }
  }
}
