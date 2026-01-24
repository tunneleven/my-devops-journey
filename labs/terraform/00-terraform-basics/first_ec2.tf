# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "first_tf_ec2" {
    ami = var.ami_ubuntu_sg
    instance_type = "t2.micro"
    tags = {
        Name = "First-Terraform-EC2"
    }
    
}