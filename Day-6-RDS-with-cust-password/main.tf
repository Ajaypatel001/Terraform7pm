# RDS MySQL Instance
resource "aws_db_instance" "mysql_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"

  identifier = "my-mysql-db-instance"
  db_name    = "mydatabase"
  username   = "adminuser"
  password   = "cloud123"

  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name  = "default.mysql8.0"

  backup_retention_period = 7
  backup_window           = "03:00-04:00"

  monitoring_interval  = 60
  monitoring_role_arn = aws_iam_role.rds.arn

  maintenance_window  = "sun:05:00-sun:06:00"
  deletion_protection = false
  skip_final_snapshot = true

  depends_on = [aws_db_subnet_group.subnet_group]
}

# create read replica
resource "aws_db_instance" "mysql_rds_replica" {
  replicate_source_db  = aws_db_instance.mysql_rds.arn
  instance_class       = "db.t3.micro"
  identifier           = "my-mysql-db-replica"

  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  monitoring_interval  = 60
  monitoring_role_arn = aws_iam_role.rds.arn

  depends_on = [aws_db_instance.mysql_rds]
}

# IAM Role for RDS Monitoring
resource "aws_iam_role" "rds" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


# VPc
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev"
  }
}


# Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "rds-subnet-1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "rds-subnet-2"
  }
}


# DB Subnet Group
resource "aws_db_subnet_group" "subnet_group" {
  name = "my-subnet-group"

  subnet_ids = [
    aws_subnet.subnet_1.id,
    aws_subnet.subnet_2.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}


# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # learning purpose
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}


# S3 Bucket
resource "aws_s3_bucket" "test_bucket" {
  bucket = "ifheiusfhidkjsk"
}
