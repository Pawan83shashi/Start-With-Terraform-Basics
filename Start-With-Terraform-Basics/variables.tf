variable "AWS_ACCESS_KEY" { 
    type = string 
    default = "AKIA2FZ5DXPD3EA6O4VQ"
}

variable "AWS_SECRET_KEY" {}

variable "INSTANCE_USERNAME" {
    default = "ec2-user"
} 

variable "AWS_REGION" {
    default = "us-east-1"
}

# Security Group
variable "Security_Group" {
    type = list
    default = ["sg-24076", "sg-12354" ]
}

#List of AMIS
variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0c02fb55956c7d316"
        us-east-2 = "ami-05692172625678b4e"
        us-west-2 = "ami-0352d5a37fb4f603f"
    }
}

#Public key
variable "PATH_TO_PUBLIC_KEY" {
    default = "levelup_key.pub"
}

#Private key
variable "PATH_TO_PRIVATE_KEY" {
    default = "levelup_key"
}

#I User Name
variable "INSTANCE_USER" { 
    default = "ec2-user"
}

