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

resource "aws_key_pair" "aws-key" {
  key_name   = "aws-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkEdgGpQHy8bbVasLvSfg6qFRsreci75X/rqDCe5eK+P6fQf1q1T6ML3Nd9AGpikoPuENfoyEaE5+xUiO3bRPwJBaDbqnFE1xFFfTpg5O2MWWzogFIU0ruOEqg0tOlC1kagP69SnqVT+wH4ZINxlawIYlbhgAQsDzvm9AVlz+Lrdsx2z4+1x6jrnXMffF9BIRnQ8Y31owyUFJagHL0iVWivZv/Ls71Ugv6hjk6TaiH7bSahk/Emm1pZxMLtO5l1x55Sh4KoegIqYwZrbA/6mHOF9qyAeIczVLjrquTxJlkS3QA/zuTfAjrTYKZ8W9bdxm6ZmxBxsdc8LH/mWAWbqG8lTUOCQsSk3XAl8kZkc9QSzITza/ATgPMSxMw2EQ0UO8xWjAJJixA1UTTJyfmbUhYxVVbovmvuqIbqopBrbvPMb+uoGGuakku5l/PyQyJHOpkKOW6X9WEjDfbM8F8SlzPSXpQ0JiLcj2zBb1luG3xuGwTbvD/HjgxgkrWzEWdgGi70FwQCBSauncWzA7dfvA10cacT4PZpAQp5haZH6bie0qHZ16f5xsmGNmExxSfvQJ76CZJIFQva32f8+//VmfxBpfRVsUhf21/e5JyArnwCo0/jGDtYAmHZBZLgd7E9Gp3WYlLHLwcNHeT8UXWfhpxiEwIeUetqnRrUEnfqNf4Gw=="
}

resource "aws_instance" "build" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  key_name      = "aws-key"
  tags = {
    name        = "build"
  }
}