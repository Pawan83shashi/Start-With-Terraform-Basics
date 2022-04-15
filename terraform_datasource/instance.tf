# Create AWS Key Pair

# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type="t2.micro"
    


  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

 
}
