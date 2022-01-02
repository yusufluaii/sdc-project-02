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



module "sosialmedia_db"{
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "sosialmedia-db"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  name     = "sosialmediadb"
  username = "user"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "3306"
  skip_final_snapshot = true
  publicly_accessible = true
  vpc_security_group_ids = [data.terraform_remote_state.sosialmedia_remote_sg.outputs.db_security_group_id]

  subnet_ids = [
                data.terraform_remote_state.sosialmedia_remote_vpc.outputs.database_subnets_id[0],
                data.terraform_remote_state.sosialmedia_remote_vpc.outputs.database_subnets_id[1],
                data.terraform_remote_state.sosialmedia_remote_vpc.outputs.database_subnets_id[2]
              ]

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"
  
  deletion_protection = false

}