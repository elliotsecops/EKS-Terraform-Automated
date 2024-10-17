variable "AWS_REGION" {
  type    = string
  default = "us-west-2"
}

variable "cluster_name" {
  type    = string
  default = "my-eks-cluster"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "desired_capacity" {
  type    = number
  default = 2
  validation {
    condition     = var.desired_capacity > 0 && var.desired_capacity <= 10
    error_message = "La capacidad deseada debe estar entre 1 y 10."
  }
}
