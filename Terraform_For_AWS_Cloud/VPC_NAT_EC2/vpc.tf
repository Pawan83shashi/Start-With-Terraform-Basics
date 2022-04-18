resource "aws_vpc" "levelup_vpc" {
    cidr_block = "10.0.0.0/16"
    instance tenancy = "default"

    tag = {
        Name = "Main"
    }
}