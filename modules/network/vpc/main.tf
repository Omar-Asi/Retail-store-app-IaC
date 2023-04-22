resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = var.tags
}



#################################################################

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.vpc.id
 
#  tags =var.tags
}







######################################################################################3


resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.vpc.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.availability_zone, count.index)
 
#  tags = var.tags
}



############################################################################################



resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.vpc.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.availability_zone, count.index)
 
#  tags = var.tags
}




resource "aws_db_subnet_group" "dbsubg" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.private_subnets[0].id , aws_subnet.private_subnets[1].id , aws_subnet.private_subnets[2].id]
}



resource "aws_elasticache_subnet_group" "bar" {
  name       = var.ec_subnet_group_name
  subnet_ids = [aws_subnet.private_subnets[0].id , aws_subnet.private_subnets[1].id , aws_subnet.private_subnets[2].id]
}




######################################################################################3




resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.vpc.id
 route {
   cidr_block = var.public_rt_cidr_block
   gateway_id = aws_internet_gateway.igw.id
 }
 
#  tags = var.tags
}







###################################################################################



resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_rt.id
}



################################################################################################################3


resource "aws_eip" "natip" {
  count      = length(var.public_subnet_cidrs)
  vpc = var.vpc_or_not
  # tags = var.tags
}


# variable "tags" {
  
# }

# output "natip" {
#   value = "${aws_eip.natip.*.id}"
# }



#############################################################################################


resource "aws_nat_gateway" "nat" {
 count      = length(var.public_subnet_cidrs)
  allocation_id = element(aws_eip.natip[*].id, count.index)
  
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

  # tags = var.tags
}





########################################################################################


resource "aws_route_table" "private_rt" {
 vpc_id = aws_vpc.vpc.id
 count = length(var.public_subnet_cidrs)
 route {
   cidr_block = var.private_rt_cidr_block
   gateway_id = element(aws_nat_gateway.nat[*].id, count.index)
 }
 
#  tags = {
#    Name = "High Available Website Private Route Table (1) ${count.index + 1}"
#  }
}



###################################################################################


resource "aws_route_table_association" "private_subnet_asso" {
 count = length(var.private_subnet_cidrs)
 subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
 route_table_id = element(aws_route_table.private_rt[*].id, count.index)
}




##################################################################################




# resource "aws_subnet" "private_subnets" {
#  count      = length(var.private_subnet_cidrs1)
#  cidr_block = element(var.private_subnet_cidrs1, count.index)
#  vpc_id     = aws_vpc.vpc.id
#  availability_zone = element(var.azs, count.index)
 
#  tags = {
#    Name = "ECS Private Subnet ${count.index + 1}"
#  }
# }





















# resource "aws_nat_gateway" "nat" {
#    count      = length(var.public_subnet_cidrs)
#   allocation_id = element(aws_eip.natip[*].id, count.index)
  
#   subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)

#   tags = {
#     Name = "ECS NAT gw ${count.index + 1}"
#   }
# }






# resource "aws_route_table" "private_rt" {
#  vpc_id = aws_vpc.vpc.id
#  count = length(var.public_subnet_cidrs)
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = element(aws_nat_gateway.nat[*].id, count.index)
#  }
 
#  tags = {
#    Name = "ECS Private Route Table ${count.index + 1}"
#  }
# }




# Association Between Web Servers' Subnets and Their Private Route Table

# resource "aws_route_table_association" "private_subnet_asso" {
#  count = length(var.public_subnet_cidrs)
#  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
#  route_table_id = element(aws_route_table.private_rt[*].id, count.index)
# }