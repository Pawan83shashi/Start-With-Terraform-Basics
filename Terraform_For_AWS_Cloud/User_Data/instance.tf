# Create AWS Key Pair
resource "aws_key_pair" "newlevelup_key" {
    key_name = "newlevelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Create Fronted Server
resource "aws_instance" "Frontend-EBS" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type="t2.micro"
    key_name = aws_key_pair.newlevelup_key.key_name
    availability_zone = "us-east-1a"
    user_data = "${file("installapache.sh")}"
    
  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "TEST"
  }
 
}