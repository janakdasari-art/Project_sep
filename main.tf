terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "k8s_sg" {
  name        = "k8s-node-sg"
  description = "Security group for Kubernetes node"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes API"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Kubernetes NodePort"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-node-sg"
  }
}

resource "aws_instance" "k8s_node" {
  ami           = "ami-0aba19e56f3eaec05"
  instance_type = "c7i-flex.large"
  key_name      = "new"

  vpc_security_group_ids = [
    aws_security_group.k8s_sg.id
  ]

  tags = {
    Name = "k8s-node"
  }
}

output "k8s_node_id" {
  value = aws_instance.k8s_node.id
}

output "k8s_node_public_ip" {
  value = aws_instance.k8s_node.public_ip
}

output "k8s_node_private_ip" {
  value = aws_instance.k8s_node.private_ip
}


