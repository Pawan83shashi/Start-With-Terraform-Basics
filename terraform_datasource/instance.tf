data "aws_availability_zones" "available" {}
data "aws_ami" "latest-ami" {
  most_recent = true
  owners = ["self"]
   
  filter {
    name   = "name"
    values = ["myami-*"]
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
    ami = data.aws_ami.latest-ami.id
    instance_type="t2.micro"
    availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

 
}
