# Create AWS Key Pair

# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type="t2.micro"
    key_name = aws_key_pair.levelup_key.key_name


  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

 
}
