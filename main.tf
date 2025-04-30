resource "aws_vpc" "custom" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "${var.project_name}-${var.env}"
    created_by = "Riswan"
  }
}