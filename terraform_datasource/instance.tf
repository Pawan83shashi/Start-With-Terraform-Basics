# Create AWS Key Pair
resource "aws_key_pair" "levelup_key" {
    key_name = "levelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

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
