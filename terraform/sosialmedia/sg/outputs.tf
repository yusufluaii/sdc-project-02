output "main_security_group_id" {
  value = module.sosialmedia_main_sg.security_group_id
}

output "db_security_group_id" {
  value = module.sosialmedia_db_sg.security_group_id
}