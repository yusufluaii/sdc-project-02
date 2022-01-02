data "terraform_remote_state" "sosialmedia_remote_vpc" {
  backend = "local"
  config = {
    path = "/home/yusuf/github/repo/sdc-project-02/terraform/backend/sosialmedia_vpc.tfstate"
   }
}



module "sosialmedia_main_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sosialmedia-main-sg"
  description = "Security group for publicly open"
  vpc_id      = data.terraform_remote_state.sosialmedia_remote_vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  depends_on = [
      data.terraform_remote_state.sosialmedia_remote_vpc
    ]
}


module "sosialmedia_db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "sosialmedia-db-sg"
  description = "Security group for publicly open"
  vpc_id      = data.terraform_remote_state.sosialmedia_remote_vpc.outputs.vpc_id

  ingress_cidr_blocks = ["10.0.0.0/16"]
  egress_rules        = ["all-all"]
  ingress_rules       = ["mysql-tcp"]
  depends_on = [
      data.terraform_remote_state.sosialmedia_remote_vpc
    ]
}
