variable "aws_region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-1"  
}
variable "aws_access_key" {
    description = "AWS Access Key"
    sensitive = true
    type = string
}

variable "aws_secret_key" {
    description = "AWS Secret Access Key"
    sensitive = true
    type = string
}

variable "ami_ubuntu_sg" {
    description = "AMI ID for Ubuntu Server"
    type = string
    default = "ami-08d59269edddde222"
}

variable "github_token" {
    description = "Github Token"
    type = string
}