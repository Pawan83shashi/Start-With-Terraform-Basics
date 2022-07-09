
resource "aws_db_subnet_group" "mariadb-subnets" {
    name = "mariadb-subnets"
    description = "Amazon RDS subnet group"
    subnet_ids = [aws_subnet.levelupvpc-private-1.id, aws_subnet.levelupvpc-private-2.id] 
}

# RDS Parameters

resource "aws_db_parameter_group" "levelup-mariadb-parameters" {
  name        = "levelup-mariadb-parameters"
  family      = "mariadb10.4"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}


# Get latest snapshot from  levelup-mariadb  DB
data "aws_db_snapshot" "db_snapshot" {
    most_recent = true
    db_instance_identifier = "mariadb"
}

#RDS Instance properties
resource "aws_db_instance" "levelup-mariadb-backup" {
  allocated_storage       = 20             # 20 GB of storage
  engine                  = "mariadb"
  engine_version          = "10.4.21"
  instance_class          = "db.t2.micro"
  identifier              = "mariadb-backup"
  db_name                 = "mariadb-backup"
  username                = "root"           # username
  password                = "mariadb141"     # password
  snapshot_identifier     = "${data.aws_db_snapshot.db_snapshot.id}"
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnets.name
  parameter_group_name    = aws_db_parameter_group.levelup-mariadb-parameters.name
  multi_az                = "false"            # set to true to have high availability: 2 instances synchronized with each other
  storage_type            = "gp2"
  backup_retention_period = 30                                         # how long you’re going to keep your backups
  availability_zone       = "us-east-1a" # prefered AZ
  skip_final_snapshot     = true                                     # skip final snapshot when doing terraform destroy
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  availability_zone       = aws_subnet.levelupvpc-private-1.availability_zone # prefered AZ

  tags = {
    Name = "levelup-mariadb-backup"
  }
}

output "rds" {
  value = aws_db_instance.levelup-mariadb-backup.endpoint
}