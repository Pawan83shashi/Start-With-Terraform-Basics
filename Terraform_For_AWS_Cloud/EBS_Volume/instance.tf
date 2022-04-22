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
    
  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "TEST"
  }
 
}

# EBS Resource Creation
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 20
  type              = "gp2"

  tags = {
    Name = "Secondary Volume Disk"
  }
}
  # Attach EBS Volumme with AWS Instance

  resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.Frontend-EBS.id
}