variable "aws_acess_key" {
    type = string
    description = "Acess key AWS"
}

variable "aws_secret_key" {
    type = string
    description = "Secret key AWS"
}

variable "aws_instance_ami" {
    type = string
    description = "Ami of AWS instance"    
}

variable "aws_instance_type" {
    type = string
    description = "Type of AWS instance"    
    # Free tier type
    default = "t2.micro"
}

 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"      
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_acess_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "my-first-server" {
  ami           = var.aws_instance_ami  
  instance_type = var.aws_instance_type
  tags = {
      Name = "ubuntu"
  }
}

resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
      Name = "production"
  }
}

resource "aws_vpc" "second-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
      Name = "production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.first-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.second-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}