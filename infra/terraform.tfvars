bucket_name = "dev-proj-1-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8dihaDUtbi4m1+Va8Aik9nziau0v2AyLRa0CE0j0N6nLDjPbLyM7zn0MW5PbN7gCnXwUdCK0AsBjhiuf0681u4BCQ2zq0x/6NOIN63rDGk1Yr255sYugC0yqb/hRhzuZ1zljA58GS5yUyBgoOLtP345xgaB+p1TtHaEbx30Ks7soCsoxyMojPZNq7gadxTncSxn/aUyoxMm6tDJZfrhA/LWfLGFvH+BXly9ieRKqGHiDeKibtbf82YX0V8rt4F9x32OSAaS0/C2WHIUEwn5fDETbT0EgwNd/a2xKqOoqTnMA+23fhJjiKObwl5buLi6Sx3NHm7I8ZEY1rOy//8tldB8FKD47gfVDh2lr2Q60D0wqJ9AV3G47h2qNkiLZ1M1mMA3HcALxQa0xrAiRMP4SeCOLMr5WMMKMKjAtRCjZPsCLXYB5sKSrRQkMVuEkPBLw+Jr/V0Mpd7W87V/hhhofzV3TouYANdmWhq4Jrpm3W47+xhXY8r1DDT2q8axHNuE8= joserubio@Joses-MacBook-Pro.local"
ec2_ami_id = "ami-049442a6cf8319180"

ec2_user_data_install_apache = ""