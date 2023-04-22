output "vpc_id" {
value = aws_vpc.vpc.id
description = "vpc_id"
}




output "private_subnets" {
value = aws_subnet.private_subnets.*.id
}



output "public_subnets" {
value = aws_subnet.public_subnets.*.id
}


output "db_subnet_group_name" {
  value = aws_db_subnet_group.dbsubg.name
}

output "ec_subnet_group_name" {
  value = aws_elasticache_subnet_group.bar.name
}