output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = [for instance in aws_instance.example : instance.id]
}

output "public_ips" {
  description = "List of public IPs for EC2 instances"
  value       = [for instance in aws_instance.example : instance.public_ip]
}

