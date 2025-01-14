resource "aws_instance" "test_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"

}

resource "aws_iam_user" "new_user" {
  name = "loadbalancer"
}


resource "aws_iam_user_policy" "new_user_pol" {
  user = aws_iam_user.new_user.name
  policy = file("policies/user-pol.json")
  name = "something-distinctive"
}

# ---------------------------- CHALLENGE ----------------------------------

variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type = list
  default = ["firstec2","secondec2"]
}

variable "ami" {
  type = map
  default = {
    "us-east-1" = "ami-08a0d1e16fc3f61ea"
    "us-west-2" = "ami-0b20a6f09484773af"
    "ap-south-1" = "ami-0e1d06225679bc1c5"
  }
}

resource "aws_instance" "app-dev" {
   ami = lookup(var.ami,var.region)
   instance_type = "t2.micro"
   count = length(var.tags)

   tags = {
     Name = element(var.tags,count.index)
     CreationDate = formatdate("DD MMM YYYY hh:mm ZZZ",timestamp())
   }
}
# ami pulled via the inition variable definition of region -> "ami-08a0d1e16fc3f61ea"
# instance type t2.micro
# 2 aws_instances are created defined by the length of the "tags" variable
# Each instance recieves a name tag, name specified in "tags" var by position
# Each instance recieves a formatted creation date, generated timestamp