module "lambda-with-role"{
  source = "./modules/lambda"
  function_name = "pointless"
  handler = "main.main"
  runtime = "python3.11"
  size = 512
  filename = "./zipper.zip"
}

module "modular-ec2" {
  source = "./modules/EC2"
  ec2_ami = "ami-019374baf467d6601"
  ec2_instance_type = "t2.micro"
  ec2_tags = {
    env = "dev"
    Name = "modular-ec2"
  }
}

