resource "aws_security_group" "first-sg" {
  name        = "first-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "first-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.first-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 100
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.first-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_instance" "test_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.first-sg.id]

  tags = {
    Name = "instance-with-sg"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.test_ec2.id
  domain   = "vpc"
}