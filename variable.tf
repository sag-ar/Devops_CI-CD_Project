variable "aws_region" {
  type        = string
  description = "aws region for infra creation"
  default     = "us-east-1"
}


variable "ingress_ports" {
  default = {
    ssh     = 22
    http    = 80
    https   = 443
    jenkins = 8080
  }
}


variable "instance_type" {
  type    = string
  default = "c7i-flex.large"
}
