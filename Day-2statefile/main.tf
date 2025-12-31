resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.medium"
    iam_instance_profile = "dev"
}