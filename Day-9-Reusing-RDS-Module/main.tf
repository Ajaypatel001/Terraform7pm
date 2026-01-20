module "dev" {
  source = "../RDS"
  vpc_cidr_block = "10.0.0.0/16"
  subnet-1_cidr_block = "10.0.0.0/24"
  subnet-1_az = "us-east-1a"
  subnet-2_cidr_block = "10.0.1.0/24"
  subnet-2_az = "us-east-1b"
  role_name = "RDS-Instance-Role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": ["monitoring.rds.amazonaws.com"]
            },
            "Action": ["sts:AssumeRole"]
        }
    ]
})
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  subnet_group_name = "my-db-subnet-group"
  identifier = "my-db-instance"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "password"
  allocated_storage = 20
  backup_retention_period = 7
  backup_window = "02:00-03:00"
  monitoring_interval = 60
  maintenance_window = "sun:04:00-sun:05:00"
  deletion_protection = true
  skip_final_snapshot = true
}