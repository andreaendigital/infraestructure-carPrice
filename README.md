# CarPrice Prediction Platform - Infrastructure

AWS infrastructure for the CarPrice Prediction Platform using Terraform.

## Architecture

- **VPC**: Custom VPC with public/private subnets
- **EC2**: t2.micro Ubuntu instance running the CarPrice app
- **ALB**: Application Load Balancer for HTTP traffic
- **RDS**: MySQL database for data storage
- **Security Groups**: SSH, HTTP, and database access

## Quick Start

```bash
cd infra
terraform init
terraform plan
terraform apply
```

## Access the Application

After deployment:
```bash
# Get connection details
terraform output alb_dns_name
terraform output ec2_public_ip

# Access via Load Balancer
http://<alb-dns-name>

# Direct EC2 access
http://<ec2-public-ip>:3000
```

## Configuration

Update `terraform.tfvars` with your settings:
- `public_key`: Your SSH public key
- `ec2_ami_id`: Ubuntu AMI ID for your region

## Application Repository

The infrastructure automatically deploys: https://github.com/andreaendigital/CarPricePredictor-Demo

## CI/CD

Jenkins pipeline included for automated deployment with plan/apply/destroy options.