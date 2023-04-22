resource "aws_iam_role" "ecs-task-role" {
  name = var.task_role_name
  assume_role_policy = "${var.task_role_assume_role_policy}"


}


resource "aws_iam_role_policy" "ecs-task-policy" {
  name = var.task_role_policy_name
  role = "${aws_iam_role.ecs-task-role.id}"
  policy = "${var.task_role_policy}"


  depends_on = [
    aws_iam_role.ecs-task-role
    ]
}