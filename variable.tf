variable "instance_type"{
  description = "attaching instance type"
  type = string
}
variable "ami_id"{
  description = "attaching instance ami-id"
  type = string 
}
variable "key_name"{
  description = "attaching key_name"
  type = string 
}
variable "vpc_cidr" {
  description = "Attching cidr for vpc"
  type = string 
}
variable "Nginx1_subnet_cidr" {
  description = "attaching cidr for vpc"
  type = string
}

  
