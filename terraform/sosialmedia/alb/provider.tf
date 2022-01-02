provider "aws" {
  region = "ap-southeast-1"
}


terraform {
  backend "local" {
  path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_alb.tfstate"    
  }
}