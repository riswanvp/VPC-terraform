variable "aws_region" {
  type = string
}
variable "project_name" {
  type = string
}
variable "env" {
  type = string
}
variable "vpc_cidr" {
  type        = string
  description = "vpc range"
}