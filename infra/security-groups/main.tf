variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "public_subnet_cidr_block" {}
variable "ec2_sg_name_for_python_api" {}

output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}

output "sg_ec2_for_python_api" {
  value = aws_security_group.ec2_sg_python_api.id

}
resource "aws_security_group" "ec2_sg_ssh_http" {
  name        = var.ec2_sg_name
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  # enable port 3000 for ALB health checks
  ingress {
    description = "Allow ALB health checks on port 3000"
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
  }

  #Outgoing request
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_mysql_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.public_subnet_cidr_block # replace with your EC2 instance security group CIDR block
  }
}

resource "aws_security_group" "ec2_sg_python_api" {
  name        = var.ec2_sg_name_for_python_api
  description = "Enable ports for CarPrice app (3000, 5000, 5002, 5004)"
  vpc_id      = var.vpc_id

  # Web Application
  ingress {
    description = "Allow traffic on port 3000 (Web App)"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
  }

  # Original port
  ingress {
    description = "Allow traffic on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }

  # Backend API
  ingress {
    description = "Allow traffic on port 5002 (Backend API)"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5002
    to_port     = 5002
    protocol    = "tcp"
  }

  # Documentation
  ingress {
    description = "Allow traffic on port 5004 (Documentation)"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5004
    to_port     = 5004
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Groups for CarPrice app ports"
  }
}