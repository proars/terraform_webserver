# -------------------------------------
# Terraform Web Server Example
# 
# Create WEB server using external user data
# -------------------------------------

provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "MyWebServer" {
  ami           = "ami-00be885d550dcee43"
  instance_type = "t2.micro"

  # Security Group
  vpc_security_group_ids = [aws_security_group.allow_HTTP.id]



  user_data = file("user_data.sh")

  tags = {
    Name    = "WEB Server"
    Owner   = "Ars"
    Project = "My Terraform WebServer"
  }
}

resource "aws_security_group" "allow_HTTP" {
  name        = "Allow HTTP"
  description = "Allow HTTP, HTTPS inbound traffic"


  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}