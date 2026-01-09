resource "aws_instance" "MyInstance" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t2.micro"

  tags = {
    Name = "MyInstance"
  }
}

resource "aws_s3_bucket" "name" {
    bucket =  "jfskdfksdflks"
    depends_on = [aws_instance.MyInstance]
  
}