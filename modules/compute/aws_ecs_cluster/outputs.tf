output "cluster_id" {
value = aws_ecs_cluster.ecs_cluster.id

}

output "capacity_provider" {
value = aws_ecs_capacity_provider.test.name

}
output "cluster_name" {
value = aws_ecs_cluster.ecs_cluster.name

}
output "namespace_arn" {
  value = aws_service_discovery_private_dns_namespace.namespace.arn
}
output "namespace_id" {
  value= aws_service_discovery_private_dns_namespace.namespace.id
}