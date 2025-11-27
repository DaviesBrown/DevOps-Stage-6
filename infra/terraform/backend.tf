terraform {
  backend "s3" {
    bucket                      = "todo-terraform-bucket"
    key                         = "tf/tfstate"
    region                      = "us-southeast-1"
    endpoints = {
      s3 = "https://us-southeast-1.linodeobjects.com"
    }
  }
}
