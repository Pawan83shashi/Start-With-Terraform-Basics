#Autoscaling Launch Configuration
resource "aws_launch_configuration" "levelup-launchconfig" {
  name_prefix = "levelup-launchconfig"
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name        = aws_key_pair.levelup_key.key_name
 
}

#Generate Key
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling group
resource "aws_autoscaling_group" "levelup-autoscaling" {
  name = "levelup-autoscalling"
  vpc_zone_identifier = ["us-east-1a"]
  launch_configuration = aws_launch_configuration.levelup-launchconfig.name
  min_size = 1
  max_size = 2
  health_check_grace_period = 200
  health_check_tyoe = "EC2"
  force_delete = "true"

  tage {
    key = "Name"
    value = "Level-up Custom EC2 Intstance"
    propagete_at_launch = true
  }
}

# Autoscaling Configuration Policy-Scaling Alarm
resource "aws_autoscaling_policy" "levelup-cpu-policy" {
  name = "level-cpu-policy"
  autoscaling_group = aws_autoscalling_group.levelup-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  Scaling_adjustment = "1"
  cooldown = "200"
  policy_type = "SimpleScalling"
}

# Autoscaling Cloudwatch Monitoring
resource "aws_cloudwatch_metric_alarm" "levelup-cpu-alarm" {
  alarm_name = "levelup-cpu-alarm"
  alarm_description = "Alarm once CPU Uses Increase"
  comparision_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscalling_group.levelup-autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.levelup-cpu-policy.arn]
}

#Auto Descaling Policy
resource "aws_autoscaling_policy" "levelup-cpu-policy-scaledown" {
  name                   = "levelup-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.levelup-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

#Auto descaling cloud watch 
resource "aws_cloudwatch_metric_alarm" "levelup-cpu-alarm-scaledown" {
  alarm_name          = "levelup-cpu-alarm-scaledown"
  alarm_description   = "Alarm once CPU Uses Decrease"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.levelup-autoscaling.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.levelup-cpu-policy-scaledown.arn]
}