#AutoScaling Launch Configuration
resource "aws_launch_configuration" "levelup-launchconfig" {
  name_prefix     = "levelup-launchconfig"
  image_id        = lookup(var.AMIS, var.AWS_REGION)
  instance_type   = "t2.micro"
  associate_public_ip_address = true
  key_name        = aws_key_pair.levelup_key_autoscaling.key_name
  security_groups = [aws_security_group.levelup-instance.id]
  user_data       = "#!/bin/bash\nyum update\nyum -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
  
  lifecycle {
    create_before_destroy = true
  }
}

  
#Generate Key
resource "aws_key_pair" "levelup_key_autoscaling" {
    key_name = "levelup_key_autoscaling"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling Group
resource "aws_autoscaling_group" "levelup-autoscaling" {
  name                      = "levelup-autoscaling"
  vpc_zone_identifier       = [aws_subnet.levelupvpc-public-1.id, aws_subnet.levelupvpc-public-2.id]
  launch_configuration      = aws_launch_configuration.levelup-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "ELB"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "LevelUp Custom EC2 instance via LB"
    propagate_at_launch = true
  }
  
}

output "ELB" {
  value = aws_elb.levelup-elb.dns_name
}

