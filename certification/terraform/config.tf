terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = "us-east-1"
}

resource "aws_instance" "build" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  metadata = {
    ssh-keys       = "root:${file("~/.aws/aws-key.pub")}"
    # for startup script use startup-script = file("build.sh")
  }
}
