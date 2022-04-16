data "aws_availability_zones" "available" {}

data "aws_ami" "latest" {
  most_recent = true
  owners = ["amazon"]
   
  image=aws ssm get-parameters-by-path --path /aws/service/ami-amazon-linux-latest --query "Parameters[].Value"

  }

  


# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = data.aws_ami.latest.image_id
    instance_type="t2.micro"
    availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "DEV"
  }

 
}
