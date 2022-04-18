data "aws_ip_ranges" "us_east_ip_range" {
    regions = ["us-east-1"]
    services = ["ec2"]
}

resource "aws_security_group" "sg_custom_us_east" {
    name = "sg_custom_us_east"

    ingress {
        description = "TLS from VPC"
        from_port = "443"
        to_port   = "443"
        protocol  = "tcp"
        cidr_blocks = data.aws_ip_ranges.us_east_ip_range.cidr_blocks
    }

    tags = {
        Name = "allow_tls"
        CreateDate = data.aws_ip_ranges.us_east_ip_range.create_date
        SyncToken  =data.aws_ip_ranges.us_east_ip_range.sync_token
    }
}