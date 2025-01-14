variable "ec2_names" {
  type = map 
  default = {
    generic = "uniform server"
  }
}

variable "env" {
  type = string
  default = "dev"
}

resource "aws_instance" "test_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = var.env == "dev" ? "t2.micro": "m5.large"

  tags = {
    env = var.env
  }
}