
variable "ami_id" {
  description = "Ubuntu AMI ID selected manually in Mumbai"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "jenkins_private_ip" {
  description = "Jenkins EC2 private IPv4 address"
  type        = string
}
variable "key_pair_name" {
  description = "Existing EC2 key pair name in Mumbai"
  type        = string
}

