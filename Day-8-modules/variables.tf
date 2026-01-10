variable "ami_id" {
    type = string
    default = "ami-068c0051b15cdb816"
  
}

variable "instance_type" {
    type = string
    default = ""
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
    default     = ""
}

variable "s3_bucket_name" {
    type = string
    default = ""
}