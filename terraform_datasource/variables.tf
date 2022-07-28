variable "AWS_ACCESS_KEY" { 
    type = string 
    default = "AKIA2FZ5DXPDTPXEDHVX"
}

variable "AWS_SECRET_KEY" {}

variable "INSTANCE_USERNAME" {
    default = "ec2-user"
} 

variable "AWS_REGION" {
    default = "us-east-1"
}

#List of AMIS
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0c02fb55956c7d316"
        
    }
}


