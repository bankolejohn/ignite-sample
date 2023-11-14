provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-06aa3f7caf3a30282"  # Specify the desired Ubuntu AMI ID
  instance_type = "t2.micro"               # Choose an appropriate instance type
  key_name      = "your-key-pair"          # Specify your key pair for SSH access

  # Add other necessary configurations such as security groups, user data, etc.

  tags = {
    Name = "docker-ec2-instance"
  }
}

# Add any other resources needed, e.g., security groups, key pairs, etc.

output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
