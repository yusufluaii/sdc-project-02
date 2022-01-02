data "terraform_remote_state" "sosialmedia_remote_vpc" {
  backend = "local"
  config = {
    path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_vpc.tfstate"
   }
}

data "terraform_remote_state" "sosialmedia_remote_alb" {
  backend = "local"
  config = {
    path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_alb.tfstate"
   }
}


module "sosialmedia_asg" {
 source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "sosialmedia-cluster"
  key_name = "yusufluai"
  vpc_zone_identifier = data.terraform_remote_state.sosialmedia_remote_vpc.outputs.public_subnets_id
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  # Launch template
  use_lt    = true
  create_lt = true
  image_id      = "ami-055d15d9cfddf7bd3"
  instance_type = "t2.micro"

  # target_group_arns = data.terraform_remote_state.sosialmedia_remote_alb.outputs.target_group_arns
}




