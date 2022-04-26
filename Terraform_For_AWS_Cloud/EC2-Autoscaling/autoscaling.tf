#Autoscaling Launch Configuration
resource "aws_launch_configuration" "levelup-launchconfig" {
  name_prefix = "levelup-launchconfig"
    image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}