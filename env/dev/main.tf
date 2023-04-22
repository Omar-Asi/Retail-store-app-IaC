terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}



provider "aws" {
  region = "us-east-2"
}





module "vpc" {
  source  = "../../modules/network/vpc"
  # vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block

  availability_zone = "${var.availability_zone}"
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs = var.public_subnet_cidrs
  vpc_or_not = var.vpc_or_not
  public_rt_cidr_block = var.public_rt_cidr_block
  private_rt_cidr_block = var.private_rt_cidr_block
  db_subnet_group_name = var.db_subnet_group_name
  ec_subnet_group_name = var.ec_subnet_group_name
  tags = {
    Name = "${var.vpc_name}"
  }

}




module "iam_task_exec_role" {
  source = "../../modules/compute/aws_iam_execution_role"
ex_role_name = var.ex_role_name
ex_policy_name = var.ex_policy_name
ex_role_assume_role_policy = "${file("${var.ex_role_assume_role_policy_path}")}"
ex_role_policy = "${file("${var.ex_role_policy_path}")}"

}






module "iam_task_role" {
  source = "../../modules/compute/aws_iam_task_role"
task_role_name = var.task_role_name
task_role_policy_name = var.task_role_policy_name
task_role_assume_role_policy = "${file("${var.task_role_assume_role_policy_path}")}"
task_role_policy = "${file("${var.task_role_policy_path}")}"

}






module "aws-ECS-sg" {
  source  = "../../modules/network/aws_ecs_sg"

  ecs_sg_name        = "ECS Security Group"
  ecs_sg_description = "ECS Security Group"
  vpc_id  = module.vpc.vpc_id
  
}





module "aws-alb-sg" {
  source  = "../../modules/network/aws_alb_sg"

  alb_sg_name        = "ALB Security Group"
  alb_sg_description = "ALB Security Group"
  vpc_id  = module.vpc.vpc_id
}




module "aws-db-sg" {
  source  = "../../modules/network/aws_db_sg"

  db_sg_name        = "DB Security Group"
  db_sg_description = "DB Security Group"
  vpc_id  = module.vpc.vpc_id
  
}




module "alb_sg_rule1" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type1
security_group_id = module.aws-alb-sg.alb_sg_id
from = var.from1
to = var.to1
sg_protocol = var.sg_protocol1
sg_cidr = var.sg_cidr1

}



module "alb_sg_rule2" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type2
security_group_id = module.aws-alb-sg.alb_sg_id
from = var.from2
to = var.to2
sg_protocol = var.sg_protocol2
sg_cidr = var.sg_cidr2

}


module "ecs_sg_rule1" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type1
security_group_id = module.aws-ECS-sg.cluster_sg_id
from = var.from1
to = var.to1
sg_protocol = var.sg_protocol1
sg_cidr = var.sg_cidr1

}



module "ecs_sg_rule2" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type2
security_group_id = module.aws-ECS-sg.cluster_sg_id
from = var.from2
to = var.to2
sg_protocol = var.sg_protocol2
sg_cidr = var.sg_cidr2

}




module "db_sg_rule1" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type1
security_group_id = module.aws-db-sg.db_sg_id
from = var.from3
to = var.to3
sg_protocol = var.sg_protocol1
sg_cidr = var.sg_cidr3

}



module "db_sg_rule2" {
  source = "../../modules/network/security_group_rule"
  
sg_rule_type= var.sg_rule_type2
security_group_id = module.aws-db-sg.db_sg_id
from = var.from3
to = var.to3
sg_protocol = var.sg_protocol1
sg_cidr = var.sg_cidr3

}





module "alb" {
  source = "../../modules/compute/aws_lb"
  alb_name = var.alb_name
  vpc_id      = "${module.vpc.vpc_id}"
  subnets = "${module.vpc.public_subnets}"
  security_groups = ["${module.aws-alb-sg.alb_sg_id}"]
  load_balancer_type = var.load_balancer_type
  alb_internal = var.alb_internal
  
}





module "alb_tg" {
  source = "../../modules/compute/aws_lb_tg"
  vpc_id = module.vpc.vpc_id
  tg_name = var.tg_name
  tg_type = var.tg_type
  tg_port = var.tg_port
  tg_protocol = var.tg_protocol
  # tg_enabled = var.tg_enabled
  # tg_healthy_threshold = var.tg_healthy_threshold
  tg_interval = var.tg_interval
  tg_matcher = var.tg_matcher
  tg_path = var.tg_path
  # tg_h_port = var.tg_h_port
  # tg_h_protocol = var.tg_h_protocol
  tg_timeout= var.tg_timeout
  # tg_unhealthy_threshold = var.tg_unhealthy_threshold
}




module "aws_lb_listener" {
  source = "../../modules/compute/aws_lb_listener"
  load_balancer_arn = module.alb.alb_arn
  target_group_arn = module.alb_tg.alb_tg_arn
  ls_port = var.ls_port
  ls_protocol = var.ls_protocol
  ls_type = var.ls_type
  depends_on = [
    module.alb_tg
  ]
}





module "catalog_rds_db"{
  source  = "../../modules/database/aws_rds"
  vpc_security_group_ids = ["${module.aws-db-sg.db_sg_id}"]
  
   db_subnet_group_name = module.vpc.db_subnet_group_name


allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.catalog_db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  identifier           = var.catalog_db_identifier
   skip_final_snapshot = var.skip_final_snapshot


   

   depends_on = [
    module.vpc ,
    module.aws-db-sg
   ]
}





module "orders_rds_db"{
  source  = "../../modules/database/aws_rds"
  vpc_security_group_ids = ["${module.aws-db-sg.db_sg_id}"]
  
   db_subnet_group_name = module.vpc.db_subnet_group_name


allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.orders_db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  identifier           = var.orders_db_identifier
   skip_final_snapshot = var.skip_final_snapshot


   

   depends_on = [
    module.vpc ,
    module.aws-db-sg
   ]
}

module "aws_dynamodb_table" {
  source = "../../modules/database/dynamodb"

}

module "aws_elasticache_cluster" {
  source = "../../modules/database/redis"
  subnet_group_name = module.vpc.ec_subnet_group_name
  }











# module "catalog_mysql" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "5.6.0"
#   identifier = "mysql-catalog"
#   create_db_option_group    = false
#   create_db_parameter_group = false
#   # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#   engine               = "mysql"
#   engine_version       = "8.0.27"
#   family               = "mysql8.0" # DB parameter group
#   major_engine_version = "8.0"      # DB option group
#   instance_class       = "db.t2.micro"
#   storage_encrypted    = false
#   allocated_storage = 20
#   db_name                = "catalog"
#   username               = "catalog_user"
#   create_random_password = false
#   password               = "ZGVmYXVsdF9wYXNzd29yZA=="
#   port                   = 3306
#   publicly_accessible    = true
#   create_db_subnet_group = true
#   db_subnet_group_name   = "mysql-catalog"
#   subnet_ids             = var.subnet_ids
#   vpc_security_group_ids = [module.catalog_rds_ingress.security_group_id]
#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"
#   backup_retention_period = 0
#   tags = {
#         Name = "RDS_SG"
#     }
# }
















module "aws_ecr_repository_ui" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.ui_ecr_repository_name
}




module "aws_ecr_repository_cart" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.cart_ecr_repository_name
}




module "aws_ecr_repository_assets" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.assets_ecr_repository_name
}





module "aws_ecr_repository_catalog" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.catalog_ecr_repository_name
}





module "aws_ecr_repository_orders" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.orders_ecr_repository_name
}




module "aws_ecr_repository_checkout" {
  source = "../../modules/compute/ecr_repository"
  ecr_repository_name = var.checkout_ecr_repository_name
}



# module "aws_ecr_repository_rabbitmq" {
#   source = "../../modules/compute/ecr_repository"
#   ecr_repository_name = var.rabbitmq_ecr_repository_name
# }








module "aws_ecs_cluster" {
  source  = "../../modules/compute/aws_ecs_cluster"
  cluster_name = var.cluster_name

  vpc_id      = "${module.vpc.vpc_id}"
  vpc_subnets = "${module.vpc.private_subnets}"

  vpc_zone_identifier = "${module.vpc.private_subnets}"
  launch_template_name = var.launch_template_name
  image_id = var.image_id
  instance_type = var.instance_type
  # desired_capacity = var.desired_count
  max_size = var.max_size
  min_size = var.min_size
    default_cooldown = var.default_cooldown

  lt_version = var.lt_version
  asg_name = var.asg_name
  # asg_policy_name = var.asg_policy_name
  # asg_policy_type = var.asg_policy_type
  # predefined_metric_type = var.predefined_metric_type
  # target_value = var.target_value
  cp_name = var.cp_name
  
  instance_iam_role = var.instance_iam_role
  managed_scaling_status = var.managed_scaling_status
  default_base = var.default_base
  default_weight = var.default_weight
}





###################################  UI  #################################

module "ui_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.ui_family
  container_definitions = "${file("${var.ui_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "ui_service" {
  source  = "../../modules/compute/aws_ecs_ui_service"
  
  service_name = var.ui_service_name
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.ui_task_definition.td_arn
  desired_count = var.desired_count
  
  #load_balancer
  alb_target_group_arn = module.alb_tg.alb_tg_arn
  container_name   = var.ui_container_name
  container_port   = var.ui_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.ui_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
  namespace = var.cluster_name
    reg_arn = module.aws_ecs_cluster.namespace_id

}

###########################################  CART #################################################3


module "cart_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.cart_family
  container_definitions = "${file("${var.cart_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "cart_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.cart_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.cart_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.cart_container_name
  # container_port   = var.cart_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.cart_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
  namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id
}


############################################ CART DB ################################################3


# module "cart_db_task_definition" {
#   source  = "../../modules/compute/aws_ecs_task_definition"
#   family = var.cart_db_family
#   container_definitions = "${file("${var.cart_db_container_definitions_path}")}"
#   task_role_arn = module.iam_task_role.ecs-task-role_arn
#   execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
#   requires_compatibilities = var.requires_compatibilities
#   network_mode = var.network_mode
#   cpu = var.cpu
#   memory = var.memory
# }





# module "cart_db_service" {
#   source  = "../../modules/compute/aws_ecs_other_services"
  
#   service_name = var.cart_db_service_name
#   # health_check_grace_period_seconds = var.health_check_grace_period_seconds
#   # launch_type = var.launch_type
#   cluster = module.aws_ecs_cluster.cluster_id
#   task_definition = module.cart_db_task_definition.td_arn
#   desired_count = var.desired_count
  
#   # #load_balancer
#   # alb_target_group_arn = module.alb_tg.alb_tg_arn
#   # container_name   = var.cart_db_container_name
#   # container_port   = var.cart_db_container_port
  
#   #network_configuration
#   subnets = "${module.vpc.private_subnets}"
#   security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
#   # assign_public_ip = var.assign_public_ip
#   service_cp_base = var.service_cp_base
#   service_cp_weight = var.service_cp_weight
#   capacity_provider = module.aws_ecs_cluster.capacity_provider
#   resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.cart_db_service_name}"
#   task_max_capacity = var.task_max_capacity
#   task_min_capacity = var.task_min_capacity
#   scale_in_cooldown = var.scale_in_cooldown
#   scale_out_cooldown = var.scale_out_cooldown
#   target_value = var.target_value
#   predefined_metric_type = var.predefined_metric_type
#     namespace = var.cluster_name
#   reg_arn = module.aws_ecs_cluster.namespace_id

# }



############################################### CATALOG  #############################################3
module "catalog_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.catalog_family
  container_definitions = "${file("${var.catalog_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "catalog_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.catalog_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.catalog_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.catalog_container_name
  # container_port   = var.catalog_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.catalog_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
    namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id

}

##############################################  ASSETS  ##############################################3

module "assets_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.assets_family
  container_definitions = "${file("${var.assets_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "assets_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.assets_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.assets_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.assets_container_name
  # container_port   = var.assets_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.assets_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
    namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id

}

############################################  CHECKOUT  ################################################

module "checkout_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.checkout_family
  container_definitions = "${file("${var.checkout_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "checkout_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.checkout_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.checkout_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.checkout_container_name
  # container_port   = var.checkout_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.checkout_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
    namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id

}

###############################################  ORDERS  #############################################3


module "orders_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.orders_family
  container_definitions = "${file("${var.orders_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "orders_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.orders_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.orders_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.orders_container_name
  # container_port   = var.orders_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.orders_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
    namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id

}

# ################################################  ORDERS DB  ############################################3

# module "orders_db_task_definition" {
#   source  = "../../modules/compute/aws_ecs_task_definition"
#   family = var.orders_db_family
#   container_definitions = "${file("${var.orders_db_container_definitions_path}")}"
#   task_role_arn = module.iam_task_role.ecs-task-role_arn
#   execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
#   requires_compatibilities = var.requires_compatibilities
#   network_mode = var.network_mode
#   cpu = var.cpu
#   memory = var.memory
# }





# module "orders_db_service" {
#   source  = "../../modules/compute/aws_ecs_other_services"
  
#   service_name = var.orders_db_service_name
#   # health_check_grace_period_seconds = var.health_check_grace_period_seconds
#   # launch_type = var.launch_type
#   cluster = module.aws_ecs_cluster.cluster_id
#   task_definition = module.orders_db_task_definition.td_arn
#   desired_count = var.desired_count
  
#   # #load_balancer
#   # alb_target_group_arn = module.alb_tg.alb_tg_arn
#   # container_name   = var.orders_db_container_name
#   # container_port   = var.orders_db_container_port
  
#   #network_configuration
#   subnets = "${module.vpc.private_subnets}"
#   security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
#   # assign_public_ip = var.assign_public_ip
#   service_cp_base = var.service_cp_base
#   service_cp_weight = var.service_cp_weight
#   capacity_provider = module.aws_ecs_cluster.capacity_provider
#   resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.orders_db_service_name}"
#   task_max_capacity = var.task_max_capacity
#   task_min_capacity = var.task_min_capacity
#   scale_in_cooldown = var.scale_in_cooldown
#   scale_out_cooldown = var.scale_out_cooldown
#   target_value = var.target_value
#   predefined_metric_type = var.predefined_metric_type
#   namespace = var.cluster_name
# reg_arn = module.aws_ecs_cluster.namespace_id

# }

###############################################  CATALOG DB  #############################################3


# module "catalog_db_task_definition" {
#   source  = "../../modules/compute/aws_ecs_task_definition"
#   family = var.catalog_db_family
#   container_definitions = "${file("${var.catalog_db_container_definitions_path}")}"
#   task_role_arn = module.iam_task_role.ecs-task-role_arn
#   execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
#   requires_compatibilities = var.requires_compatibilities
#   network_mode = var.network_mode
#   cpu = var.cpu
#   memory = var.memory
# }





# module "catalog_db_service" {
#   source  = "../../modules/compute/aws_ecs_other_services"
  
#   service_name = var.catalog_db_service_name
#   # health_check_grace_period_seconds = var.health_check_grace_period_seconds
#   # launch_type = var.launch_type
#   cluster = module.aws_ecs_cluster.cluster_id
#   task_definition = module.catalog_db_task_definition.td_arn
#   desired_count = var.desired_count
  
#   # #load_balancer
#   # alb_target_group_arn = module.alb_tg.alb_tg_arn
#   # container_name   = var.catalog_db_container_name
#   # container_port   = var.catalog_db_container_port
  
#   #network_configuration
#   subnets = "${module.vpc.private_subnets}"
#   security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
#   # assign_public_ip = var.assign_public_ip
#   service_cp_base = var.service_cp_base
#   service_cp_weight = var.service_cp_weight
#   capacity_provider = module.aws_ecs_cluster.capacity_provider
#   resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.catalog_db_service_name}"
#   task_max_capacity = var.task_max_capacity
#   task_min_capacity = var.task_min_capacity
#   scale_in_cooldown = var.scale_in_cooldown
#   scale_out_cooldown = var.scale_out_cooldown
#   target_value = var.target_value
#   predefined_metric_type = var.predefined_metric_type
#   namespace = var.cluster_name
# reg_arn = module.aws_ecs_cluster.namespace_id

# }

###############################################  REDIS  ############################################3


# module "redis_task_definition" {
#   source  = "../../modules/compute/aws_ecs_task_definition"
#   family = var.redis_family
#   container_definitions = "${file("${var.redis_container_definitions_path}")}"
#   task_role_arn = module.iam_task_role.ecs-task-role_arn
#   execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
#   requires_compatibilities = var.requires_compatibilities
#   network_mode = var.network_mode
#   cpu = var.cpu
#   memory = var.memory
# }





# module "redis_service" {
#   source  = "../../modules/compute/aws_ecs_other_services"
  
#   service_name = var.redis_service_name
#   # health_check_grace_period_seconds = var.health_check_grace_period_seconds
#   # launch_type = var.launch_type
#   cluster = module.aws_ecs_cluster.cluster_id
#   task_definition = module.redis_task_definition.td_arn
#   desired_count = var.desired_count
  
#   # #load_balancer
#   # alb_target_group_arn = module.alb_tg.alb_tg_arn
#   # container_name   = var.redis_container_name
#   # container_port   = var.redis_container_port
  
#   #network_configuration
#   subnets = "${module.vpc.private_subnets}"
#   security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
#   # assign_public_ip = var.assign_public_ip
#   service_cp_base = var.service_cp_base
#   service_cp_weight = var.service_cp_weight
#   capacity_provider = module.aws_ecs_cluster.capacity_provider
#   resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.redis_service_name}"
#   task_max_capacity = var.task_max_capacity
#   task_min_capacity = var.task_min_capacity
#   scale_in_cooldown = var.scale_in_cooldown
#   scale_out_cooldown = var.scale_out_cooldown
#   target_value = var.target_value
#   predefined_metric_type = var.predefined_metric_type
#     namespace = var.cluster_name
#   reg_arn = module.aws_ecs_cluster.namespace_id

# }

###############################################  RABBITMQ  #############################################3


module "rabbitmq_task_definition" {
  source  = "../../modules/compute/aws_ecs_task_definition"
  family = var.rabbitmq_family
  container_definitions = "${file("${var.rabbitmq_container_definitions_path}")}"
  task_role_arn = module.iam_task_role.ecs-task-role_arn
  execution_role_arn = module.iam_task_exec_role.ecs-ex-role_arn
  requires_compatibilities = var.requires_compatibilities
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
}





module "rabbitmq_service" {
  source  = "../../modules/compute/aws_ecs_other_services"
  
  service_name = var.rabbitmq_service_name
  # health_check_grace_period_seconds = var.health_check_grace_period_seconds
  # launch_type = var.launch_type
  cluster = module.aws_ecs_cluster.cluster_id
  task_definition = module.rabbitmq_task_definition.td_arn
  desired_count = var.desired_count
  
  # #load_balancer
  # alb_target_group_arn = module.alb_tg.alb_tg_arn
  # container_name   = var.rabbitmq_container_name
  # container_port   = var.rabbitmq_container_port
  
  #network_configuration
  subnets = "${module.vpc.private_subnets}"
  security_groups = ["${module.aws-ECS-sg.cluster_sg_id}"]
  # assign_public_ip = var.assign_public_ip
  service_cp_base = var.service_cp_base
  service_cp_weight = var.service_cp_weight
  capacity_provider = module.aws_ecs_cluster.capacity_provider
  resource_id = "service/${module.aws_ecs_cluster.cluster_name}/${var.rabbitmq_service_name}"
  task_max_capacity = var.task_max_capacity
  task_min_capacity = var.task_min_capacity
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  target_value = var.target_value
  predefined_metric_type = var.predefined_metric_type
    namespace = var.cluster_name
  reg_arn = module.aws_ecs_cluster.namespace_id

}

############################################################################################3
