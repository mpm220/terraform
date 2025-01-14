variable "ec2_names" {
  type = map 
  default = {
    generic = "uniform server"
  }
}

resource "aws_instance" "test_ec2" {
  count = 4
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"

  tags = {
    Name = var.ec2_names.generic
    replication_num = count.index
  }
}