resource "aws_instance" "name" {
    ami          =var.ami_id
    instance_type= var.instance_type
}

resource "aws_vpc" "test" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnet1" {
    vpc_id     = aws_vpc.test.id
    cidr_block = var.subnet_cidr
    tags = {
        Name = "MySubnet"
    }   
}

resource "aws_s3_bucket" "b" {
    bucket = var.s3_bucket_name
    
}