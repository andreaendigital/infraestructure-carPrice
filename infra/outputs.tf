output "dev_proj_1_vpc_id" {
  value = module.networking.dev_proj_1_vpc_id
}

output "alb_dns_name" {
  value = module.alb.aws_lb_dns_name
  description = "Application Load Balancer DNS name for accessing the app"
}

output "ec2_public_ip" {
  value = module.ec2.dev_proj_1_ec2_instance_public_ip
  description = "EC2 public IP for direct access"
}