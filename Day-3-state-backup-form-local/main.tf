resource "aws_instance" "name" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t2.medium"

  tags = {
    Name = "test"
  }
}

resource "aws_s3_bucket" "dev" {
  bucket = "dev-qa-bucket-12345"
}


