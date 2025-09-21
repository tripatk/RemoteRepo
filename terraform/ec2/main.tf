resource "aws_instance" "example" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]


  subnet_id = data.aws_subnets.default.ids[2] # Use the first subnet

  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl enable httpd
            systemctl start httpd
            echo "<h1>Hello from Terraform static website!</h1>" > /var/www/html/index.html
            EOF

  tags = {
    Name = "terraform-static-website"
  }
}
resource "aws_security_group" "web_sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust for security (e.g., restrict to your IP)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
