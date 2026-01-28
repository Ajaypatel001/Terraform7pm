data "aws_subnets" "name" {
  filter {
    name   = "tag:Name"
    values = ["MySubnet"]
  }
}


resource "aws_instance" "name" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t2.micro"

  subnet_id = data.aws_subnets.name.id
}
