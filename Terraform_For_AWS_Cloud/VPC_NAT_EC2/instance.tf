# Create AWS Key Pair
resource "aws_key_pair" "newlevelup_key" {
    key_name = "newlevelup_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Create Fronted Server
resource "aws_instance" "Frontend" {
    ami = lookup(var.AMIS, var.AWS_REGION)
    instance_type="t2.micro"
    key_name = aws_key_pair.newlevelup_key.key_name
    vpc_security_group_ids = [aws_security_group.allow-levelup-ssh.id]
    subnet_id = aws_subnet.levelupvpc-public-1.id

  tags = {
    Name = "Frontend_Server"
    Project = "BMT"
    Environment = "TEST"
  }

  
}
