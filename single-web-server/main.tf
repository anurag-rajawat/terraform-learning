terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

# By default, AWS does not allow any incoming or outgoing traffic from an EC2 Instance.
# To allow the EC2 Instance to receive traffic on port 8080, you need to create a security group
resource "aws_security_group" "instance" {
  name = "web-server-example"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  # The <<-EOF and EOF are Terraform’s heredoc syntax, which allows you to create
  # multiline strings without having to insert \n characters all over the place.
  # You pass a shell script to User Data by setting the user_data argument
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF
  # The user_data_replace_on_change parameter is set to true so that when you change the user_data parameter and run apply,
  # terraform will terminate the original instance and launch a totally new one.
  user_data_replace_on_change = true
  tags = {
    "Name" = "web-server"
  }
}
