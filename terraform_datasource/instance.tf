data "aws_availability_zones" "available" {}

# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type="t2.micro"
    availability_zone = data.aws_availability_zones.available.names[1]
  
  provisioner "local-exec" {
    command = "echo  aws_instance.Frontend.private_ip >>my_private_ips.txt"
  }

  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

  

}

output "public_ip" {
    value = aws_instance.Frontend.public_ip
  }
