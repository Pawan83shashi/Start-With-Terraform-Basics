provider "aws" {
    access_key="AKIA2FZ5DXPD3EA6O4VQ"
    secret_key="SECRET_KEY"
    region="us-east-1"
}

resources "aws_instance" "Frontend" {
    ami="ami-0c02fb55956c7d316"
    instance_type="t2.micro"
}