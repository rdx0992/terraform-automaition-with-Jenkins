provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

# Create internet gateway and attach it to the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my_internet_gateway"
  }
}

# Create security group with firewall rules
resource "aws_security_group" "jenkins-sg-2022" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
}

resource "aws_instance" "myFirstInstance" {
  ami = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins-sg-2022.id]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address and associate it with the EC2 instance
resource "aws_eip" "myFirstInstance" {
  vpc = true
  tags= {
    Name = "my_elastic_ip"
  }
}

resource "aws_eip_association" "myFirstInstance" {
  instance_id = aws_instance.myFirstInstance.id
  allocation_id = aws_eip.myFirstInstance.id
  vpc_id = aws_vpc.main.id
  depends_on = [aws_internet_gateway.gw]
}
