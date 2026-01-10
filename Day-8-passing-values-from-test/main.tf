module "test" {
    source = "../Day-8-modules"
    ami_id = "ami-068c0051b15cdb816"
    instance_type = "t2.medium"
    vpc_cidr = "10.0.0.0/16"
    s3_bucket_name = "kfg-test-bucket-12345"
}