### Availability zones ###
availability_zone = ["us-east-2a", "us-east-2b", "us-east-2c"]




vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]


public_subnet_name =   "ECS Public Subnet"

private_subnet_name = "ECS Private Subnet"
   
vpc_name = "ECS VPC"

public_rt_cidr_block = "0.0.0.0/0"

private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24",]
 
private_rt_cidr_block = "0.0.0.0/0"
igw_name = "ECS IG"

public_rt_name = "ECS Public Route Table"

private_rt_name = "ECS Private Route Table"


eip_name = "NAT EIP"



nat_name = "NAT GW"



vpc_or_not = true

db_subnet_group_name = "db_subnet_group"

ec_subnet_group_name = "ec-subnet-group"










allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  catalog_db_name              = "catalogdb"
  username             = "user1"
  password             = "passw0rd"
  parameter_group_name = "default.mysql5.7"
  catalog_db_identifier           = "catalog-database"
   skip_final_snapshot = true


  orders_db_name              = "ordersdb"
  orders_db_identifier           = "orders-database"


ui_ecr_repository_name = "ui"
cart_ecr_repository_name = "cart"
catalog_ecr_repository_name = "catalog"
checkout_ecr_repository_name = "checkout"
orders_ecr_repository_name = "orders"
assets_ecr_repository_name = "assets"
rabbitmq_ecr_repository_name = "rabbitmq"







### ECS execution task role ###

ex_role_name = "ecs-task-ex-role"
ex_policy_name = "ecs-task-ex-role-policy"
ex_role_assume_role_policy_path = "json_files/ecs-ex-role.json"
ex_role_policy_path = "json_files/ecs-ex-policy.json"

sg_rule_type1 = "ingress"
sg_rule_type2 = "egress"
sg_protocol1 = "tcp"
sg_protocol2 = "-1"
sg_cidr1 = ["0.0.0.0/0"]
sg_cidr2 = ["0.0.0.0/0"]
sg_cidr3 = ["10.0.0.0/16"]
from1 = 8080
from2 = 80
to1 =  8080
to2 = 8080
from3 = 3306
to3 = 3306

  
  



### ECS task role ###

task_role_name = "ecs-task-role"
task_role_policy_name = "ecs-task-role-policy"
task_role_assume_role_policy_path = "json_files/ecs-task-role.json"
task_role_policy_path = "json_files/ecs-task-policy.json"




### ALB target group ###

tg_name = "ECS-alb-tg"
tg_type = "ip"
tg_port = 8080
tg_protocol = "HTTP"

# health check
  
  # tg_enabled = true
  # tg_healthy_threshold = 3
  tg_interval = 30
  tg_matcher = 303
  tg_path = "/"
  # tg_h_port = "traffic-port"
  # tg_h_protocol = "HTTP"
  tg_timeout = 15
  # tg_unhealthy_threshold = 2




### ALB listener ###

ls_port = "8080"
ls_protocol = "HTTP"

# defualt action
  ls_type = "forward"





### ALB ###

alb_name = "ECS-ALB"
alb_internal = false
load_balancer_type = "application"




### ECS Service ###

# launch_type = "FARGATE"
health_check_grace_period_seconds = 10
desired_count = 1


################################################
ui_service_name = "ui_service"
ui_container_name   = "ui_container"
ui_container_port   = 8080
ui_container_definitions_path = "json_files/ui_container_definition.json"
ui_family = "ui_tdf"
###################################################

################################################
catalog_service_name = "catalog_service"
# catalog_container_name   = "catalog_container"
# catalog_container_port   = 8080
catalog_container_definitions_path = "json_files/catalog_container_definition.json"
catalog_family = "catalog_tdf"
###################################################

################################################
catalog_db_service_name = "catalog_db_service"
# catalog_db_container_name   = "catalog_db_container"
# catalog_db_container_port   = 8080
catalog_db_container_definitions_path = "json_files/catalog_db_container_definition.json"
catalog_db_family = "catalog_db_tdf"
###################################################

################################################
assets_service_name = "assets_service"
# assets_container_name   = "assets_container"
# assets_container_port   = 8080
assets_container_definitions_path = "json_files/assets_container_definition.json"
assets_family = "assets_tdf"
###################################################

################################################
cart_service_name = "cart_service"
# cart_container_name   = "cart_container"
# cart_container_port   = 8080
cart_container_definitions_path = "json_files/cart_container_definition.json"
cart_family = "cart_tdf"
###################################################

################################################
cart_db_service_name = "cart_db_service"
# cart_db_container_name   = "cart_db_container"
# cart_db_container_port   = 8000
cart_db_container_definitions_path = "json_files/cart_db_container_definition.json"
cart_db_family = "cart_db_tdf"
###################################################

################################################
redis_service_name = "redis_service"
# redis_container_name   = "redis_container"
# redis_container_port   = 6379
redis_container_definitions_path = "json_files/redis_container_definition.json"
redis_family = "redis_tdf"
###################################################

################################################
checkout_service_name = "checkout_service"
# checkout_container_name   = "checkout_container"
# checkout_container_port   = 8080
checkout_container_definitions_path = "json_files/checkout_container_definition.json"
checkout_family = "checkout_tdf"
###################################################

################################################
rabbitmq_service_name = "rabbitmq_service"
# rabbitmq_container_name   = "rabbitmq_container"
# rabbitmq_container_port   = 5672
rabbitmq_container_definitions_path = "json_files/rabbitmq_container_definition.json"
rabbitmq_family = "rabbitmq_tdf"
###################################################

################################################
orders_service_name = "orders_service"
# orders_container_name   = "orders_container"
# orders_container_port   = 8080
orders_container_definitions_path = "json_files/orders_container_definition.json"
orders_family = "orders_tdf"
###################################################

###############################################
orders_db_service_name = "orders_db_service"
# orders_db_container_name   = "orders_db_container"
# orders_db_container_port   = 3306
orders_db_container_definitions_path = "json_files/orders_db_container_definition.json"
orders_db_family = "orders_db_tdf"
###################################################


# assign_public_ip = true
service_cp_base = 0
service_cp_weight = 1

### ECS Cluster ###

cluster_name = "My_App_cluster"

lt_version = "$Latest"
target_value       = 70
    scale_in_cooldown  = 1
    scale_out_cooldown = 1
  task_max_capacity = 5
task_min_capacity = 1

managed_scaling_status = "ENABLED"
default_base = 0
default_weight = 1

# vpc_zone_identifier = ["us-east-2a", "us-east-2b", "us-east-2c"]

launch_template_name = "ECS-launch-template"
  image_id = "ami-0798aaad33ff8890b"
  instance_type = "t2.medium"
  default_cooldown = 0
  max_size = 10
  min_size = 1
  asg_name = "ECS-ASG"
  # asg_policy_name = "ECS-ASG-TargetTrackingPolicy"
  # asg_policy_type = "TargetTrackingScaling"
  predefined_metric_type = "ECSServiceAverageCPUUtilization"
  # target_value = 50.0
  cp_name = "capacity_provider_1"
instance_iam_role = "arn:aws:iam::926837946404:instance-profile/ecsInstanceRole"

### ECS Task Definition ###

requires_compatibilities = ["EC2"]
network_mode = "awsvpc"
cpu = "1024"
memory = "1024"

