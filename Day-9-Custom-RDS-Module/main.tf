resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = var.subnet-1_cidr_block
  availability_zone = var.subnet-1_az
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = var.subnet-2_cidr_block
  availability_zone = var.subnet-2_az
  tags = {
    Name = "subnet-2"
  }
}

resource "aws_iam_role" "name" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}
resource "aws_iam_role_policy_attachment" "name" {
  role       = aws_iam_role.name.name
  policy_arn = var.policy_arn
}

resource "aws_db_subnet_group" "name" {
  name       = var.subnet_group_name
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
}

resource "aws_db_instance" "name" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.name.name
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = aws_iam_role.name.arn
  maintenance_window      = var.maintenance_window
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = var.skip_final_snapshot
}