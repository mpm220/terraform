locals {
  ingress_rules = [
    {
      port = 1111
      desc = "port num"
    },
    { 
      port = 2222
      desc = "another num"
    }
  ]
}


resource "aws_security_group" "first-sg" {
  name        = "first-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  tags = {
    Name = "first-sg"
  }
  dynamic "ingress" {
    for_each = local.ingress_rules
    iterator = thing
    content {
      description = thing.value.desc
      from_port = thing.value.port
      to_port = thing.value.port
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# variable "sg-ingress-rules" {
#   type = map(object(
#     {
#     cidr_ipv4         = string
#     from_port         = number
#     ip_protocol       = string
#     to_port           = number
#     }
#   ))
#   default = {
#     one = {
#       cidr_ipv4         = "0.0.0.0/0"
#       from_port         = 10
#       ip_protocol       = "tcp"
#       to_port           = 100
#     }
#     two = {
#       cidr_ipv4         = "0.0.0.0/0"
#       from_port         = 1010
#       ip_protocol       = "tcp"
#       to_port           = 100
#     },
#   }
    
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   for_each = var.sg-ingress-rules

#   security_group_id = aws_security_group.first-sg.id
#   cidr_ipv4         = each.value.cidr_ipv4
#   from_port         = each.value.from_port
#   ip_protocol       = each.value.ip_protocol
#   to_port           = each.value.to_port
# }

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.first-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}