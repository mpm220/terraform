resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_security_group" "first-sg" {
  name        = "first-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "first-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.first-sg.id
  cidr_ipv4 = "${aws_eip.lb.public_ip}/32"
  from_port         = 433
  ip_protocol       = "tcp"
  to_port           = 433
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.first-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
