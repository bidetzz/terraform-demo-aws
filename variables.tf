variable "public_key_path" {
    type = string
    description = "Path of the public SSH key to be deployed to the EC2 instances. For example: path/to/public/key/pub_key.pub"
}

variable "vpc_id" {
    type = string
    description = "VPC id of the existing VPC to provision your resources"
}

variable "subnet_id" {
    type = string
    description = "subnet id of the VPC to provision your resources"
}

variable "aws_region" {
    type = string
    description = "The AWS region to provision your resources"
}

variable "ec2_instance_type" {
    type = string
    description = "The type of the EC2 instances"
    default = "t2.micro"
}
