data "aws_availability_zones" "available" {}

data "aws_ami_ids" "latest" {
  #most_recent = true
  owners = ["amazon"]
   
  filter {
    name   = "name"
    values = ["/aws/service/ami-amazon-linux-latest/amzn*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
  


# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = data.aws_ami_ids.latest.id
    instance_type="t2.micro"
    availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

 
}
