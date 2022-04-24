provider "aws" {
  region     = "eu-west-1"
  access_key = "aws-access-key"
  secret_key = "aws-secret-key"
}

resource "aws_instance" "name" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  tags {
    Name = "terraform-test"
  }

}
/***
* create resource vpc
*/
resource "aws_vpc" "vpc" {
  cidr_block = "10,10,10,10/16"
  tags {
    Name = "terraform-test"
  }
}
/***
* create resource subnet
*/
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10,10,10,10/24"
  availability_zone = "eu-west-1a"
  tags {
    Name = "terraform-test"
  }
}
/***
* create internet gateway
*/
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "terraform-test"
  }
}
/***
* create costume route table
*/
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  tags {
    Name = "terraform-test"
  }
}
/***
* create association between route table and internet gateway
*/
resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}
/***
* create security group to allow port 22, 80 and 443
*/
resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.vpc.id
  description = "terraform-test"
  ingress {
    description = "Allow https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  ingress {
    description = "Allow http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  ingress {
    description = "Allow ssh access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }
  tags {
    Name = "terraform-test"
  }
}
/***
* create network interface with ip in the subnet
*/
resource "aws_network_interface" "nic" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = [aws_vpc.vpc.cidr_block]
  security_groups = ["${aws_security_group.sg.id}"]
  tags {
    Name = "terraform-test"
  }
  attachment {
    instance     = aws_instance.name.id
    device_index = 0
  }


}

/***
* assign elastic ip to the network interface
*/
resource "aws_eip" "eip" {
  vpc                       = true
  network_interface         = aws_network_interface.nic.id
  associate_with_private_ip = "10.10.10.10"
  depends_on = [
    aws_internet_gateway.igw,
  ]
}
/***
* create server with the elastic ip and enable apache2
*/
resource "aws_instance" "web" {
  ami               = "ami-12345678"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  tags {
    Name = "web-server"
  }
  network_interface {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    network_interface_id        = aws_network_interface.nic.id
  }
  depends_on = [
    aws_eip.eip,
  ]
  user_data = <<EOT
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo service apache2 start
                sudo apt-get install -y php
                sudo bash 'echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php'
                EOT


}