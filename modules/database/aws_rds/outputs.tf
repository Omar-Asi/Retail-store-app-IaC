output "DatabaseName" {
value = aws_db_instance.rds_db.db_name
description = "The Database Name!"
}
output "DatabaseUserName" {
value = aws_db_instance.rds_db.username
description = "The Database Name!"
}
output "DBConnectionString" {
value = aws_db_instance.rds_db.endpoint
description = "The Database connection String!"
}

output "db_endpoint" {
  value = aws_db_instance.rds_db.endpoint
}