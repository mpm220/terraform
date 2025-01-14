resource "aws_instance" "my_first_ec2" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"

  tags = {
    Name = "diff-name"
  }
}

resource "aws_eip" "lb" {
  domain = "vpc"
}


resource "aws_iam_role" "aws_user" {
  name = "demo_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# resource "github_repository" "repo" {
#   name        = "terra-repo"
#   description = "a repo for testing terraform learnings"
# }
