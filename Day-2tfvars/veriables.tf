variable "ami_id" {
  description = "passing value to main.tf"
  type = string
  default = "ami-068c0051b15cdb816"
}

variable "type" {
  type = string
  default = "t2.micro"
}