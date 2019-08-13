resource "aws_security_group" "fargate_tasks" {
  name        = "security-group-${var.fargate_cluster_name}"
  description = "allow inbound access from the ALB only"
  vpc_id = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.fargate_container_port
    to_port         = var.fargate_container_port
    security_groups = [var.fargate_alb_security_group_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}


resource "aws_ecs_cluster" "main" {
  name = var.fargate_cluster_name

  tags = var.tags
}


resource "aws_ecs_task_definition" "app" {
  container_definitions = var.fargate_container_definitions
  family = var.faragte_app_name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.fargate_cpu
  memory = var.fargate_memory
  execution_role_arn = var.fargate_task_execution_role_arn
  tags = var.tags
}

resource "aws_ecs_service" "main" {
  name            = var.faragte_app_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.fargate_app_count
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = ["desired_count", "task_definition"]
  }

  network_configuration {
    security_groups  = [aws_security_group.fargate_tasks.id]
    subnets = var.fargate_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.fargate_alb_target_group_id
    container_name   = var.fargate_container_name
    container_port   = var.fargate_container_port
  }
}

resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = var.fargate_autoscaling_role_arn
  min_capacity       = var.fargate_app_min_count
  max_capacity       = var.fargate_app_max_count
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "up" {
  name               = "cb_scale_up"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "down" {
  name               = "cb_scale_down"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.target]
}

# Cloudwatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
  alarm_name          = "cpu_utilization_high_${var.fargate_cluster_name}}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "65"

  dimensions  = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name
  }

  alarm_actions = [aws_appautoscaling_policy.up.arn]
}

# Cloudwatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
  alarm_name          = "cpu_utilization_low_${var.fargate_cluster_name}}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.main.name
  }

  alarm_actions = [aws_appautoscaling_policy.down.arn]
}

resource "aws_cloudwatch_log_group" "cb_log_group" {
  name              = "/ecs/${var.faragte_app_name}"
  retention_in_days = 30

  tags = {
    Name = "fargate-logs"
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "${var.faragte_app_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.cb_log_group.name
}
