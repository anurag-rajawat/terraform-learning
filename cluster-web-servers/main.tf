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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow ingress traffic on servers"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "web_config" {
  image_id        = "ami-0fb653ca2d3203ac1"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Namaste, world" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = aws_launch_configuration.web_config.name
  vpc_zone_identifier  = data.aws_subnets.default.ids
  min_size             = 1
  max_size             = 50
  tag {
    key                 = "name"
    value               = "terraform-example"
    propagate_at_launch = true
  }
}
