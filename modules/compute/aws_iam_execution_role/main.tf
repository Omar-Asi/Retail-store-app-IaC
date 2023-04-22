resource "aws_iam_role" "ecs-ex-role" {
  name = var.ex_role_name
  assume_role_policy = "${var.ex_role_assume_role_policy}"


}


resource "aws_iam_role_policy" "ecs-ex-policy" {
  name = var.ex_policy_name
  role = "${aws_iam_role.ecs-ex-role.id}"
  policy = "${var.ex_role_policy}"
depends_on = [
    aws_iam_role.ecs-ex-role
    ]
  
}




