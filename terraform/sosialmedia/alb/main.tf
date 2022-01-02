data "terraform_remote_state" "sosialmedia_remote_vpc" {
  backend = "local"
  config = {
    path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_vpc.tfstate"
   }
}

data "terraform_remote_state" "sosialmedia_remote_sg" {
  backend = "local"
  config = {
    path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_sg.tfstate"
   }
}



module "sosialmedia_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "sosialmedia-alb"

  vpc_id          = data.terraform_remote_state.sosialmedia_remote_vpc.outputs.vpc_id
  subnets         = [
                    data.terraform_remote_state.sosialmedia_remote_vpc.outputs.public_subnets_id[0],
                    data.terraform_remote_state.sosialmedia_remote_vpc.outputs.public_subnets_id[1],
                    data.terraform_remote_state.sosialmedia_remote_vpc.outputs.public_subnets_id[2]
                  ]
  security_groups = [data.terraform_remote_state.sosialmedia_remote_sg.outputs.main_security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name             = "sosmed"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
  ]

  tags = {Name = "sosialmedia"}
}