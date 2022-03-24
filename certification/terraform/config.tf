terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
#  shared_config_file      = "/home/user/.aws/config"
  shared_credentials_file = "/home/user/.aws/credentials"
  region                  = "us-east-1"
}

resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key"
  public_key = file("/home/user/.aws/aws-key.pub")
}

resource "aws_security_group" "build-prod" {
  name        = "build-prod"
  description = "Allow ssh input and public out traffic"

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    protocol  = "tcp"
    to_port   = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "build-prod"
}
}

resource "aws_instance" "build" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = "aws-key"
  security_groups = ["build-prod"]

  tags = {
    Name        = "build"
  }
  depends_on = [aws_key_pair.aws-key, aws_security_group.build-prod]
}

resource "aws_instance" "prod" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = "aws-key"
  security_groups = ["build-prod"]

  tags = {
    Name        = "prod"
  }
  depends_on = [aws_key_pair.aws-key, aws_security_group.build-prod]
}