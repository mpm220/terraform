resource "aws_instance" "test_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"
}