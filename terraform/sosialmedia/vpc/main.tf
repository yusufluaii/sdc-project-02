# data "terraform_remote_state" "sosialmedia_remote_sg" {
#   backend = "local"
#   config = {
#     path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_sg.tfstate"
#    }
# }


module "sosialmedia_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "sosialmedia-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.21.0/24","10.0.22.0/24","10.0.23.0/24"]

  tags = {
    Terraform = "true"
    Environment = "prod"
    App = "SosialMedia"
  }
 
}


