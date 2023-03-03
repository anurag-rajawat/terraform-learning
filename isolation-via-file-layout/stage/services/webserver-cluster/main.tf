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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# This terraform_remote_state data source configures the web server cluster code to read the state file
# from the same S3 bucket and folder where the database stores its state,
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraform-state-s3-example"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-2"
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

  # Render the User Data script as a template
  user_data = templatefile("user-data.sh", {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  max_size             = 50
  min_size             = 1
  launch_configuration = aws_launch_configuration.web_config.id
  vpc_zone_identifier  = data.aws_subnets.default.ids
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "terraform-example"
  }
}
