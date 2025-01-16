data "aws_ami" "latest_image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["ubuntu-minimal/images-testing/hvm-ssd-gp3/ubuntu-plucky-daily-arm64-minimal*"]
  }
}

data "aws_security_group" "my_g" {
  filter {
    name = "group-name"
    values = ["first-sg"]
  }
}


resource "aws_instance" "test_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"
}

