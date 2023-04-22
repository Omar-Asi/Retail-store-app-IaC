resource "aws_db_instance" "rds_db" {
 
 
   
   vpc_security_group_ids = var.vpc_security_group_ids
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  identifier           = var.identifier
   skip_final_snapshot = var.skip_final_snapshot
   db_subnet_group_name = var.db_subnet_group_name

   
}