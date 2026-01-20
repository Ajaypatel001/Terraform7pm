variable "vpc_cidr_block" {
  type    = string
  default = ""
}

#TODO: #vpc name variable

variable "subnet-1_cidr_block" {
  type    = string
  default = ""
}

variable "subnet-1_az" {
  type    = string
  default = ""
}

#TODO: #subnet-1 name variable

variable "subnet-2_cidr_block" {
  type    = string
  default = ""
}

variable "subnet-2_az" {
  type    = string
  default = ""
}

#TODO: #subnet-2 name variable

variable "role_name" {
  type    = string
  default = ""
}

variable "assume_role_policy" {
  type    = string
  default = ""
}

variable "policy_arn" {
  type    = string
  default = ""
}

variable "subnet_group_name" {
  type    = string
  default = ""
}
# variable "subnet_ids" {
#   type = string
#   default = ""
# }

variable "identifier" {
  type    = string
  default = ""
}

variable "engine" {
  type    = string
  default = ""
}

variable "engine_version" {
  type    = string
  default = ""
}

variable "instance_class" {
  type    = string
  default = ""
}

variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "allocated_storage" {
  type    = string
  default = ""
}

variable "backup_retention_period" {
  type    = string
  default = ""
}

variable "backup_window" {
  type    = string
  default = ""
}

variable "monitoring_interval" {
  type    = string
  default = ""
}

variable "maintenance_window" {
  type    = string
  default = ""
}

variable "deletion_protection" {
  type    = string
  default = ""
}

variable "skip_final_snapshot" {
  type    = string
  default = ""
}