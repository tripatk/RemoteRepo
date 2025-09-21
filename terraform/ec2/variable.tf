variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0861f4e788f5069dd"
}
output "website_url" {
  value = "http://${aws_instance.example[0].public_ip}"
}

