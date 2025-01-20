# Define the key pair for SSH access
resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key
}

resource "aws_instance" "react_server" {
  ami           = "ami-019374baf467d6601"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = file("user_data.sh")
  tags = {
    name = "react-ec2"
  }
  associate_public_ip_address = true

  depends_on = [aws_security_group.allow_http]
}


resource "aws_s3_bucket" "my_s3" {
  bucket = "storage-for-dummy-generator-2025-01-19"
}

resource "aws_s3_bucket_public_access_block" "react_bucket_bpa" {
  bucket                  = aws_s3_bucket.my_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "react_app_zip"  {
  bucket = aws_s3_bucket.my_s3.id
  key    = "app.7z"
  source = "C:\\Users\\mille\\Projects\\terraform\\generator_deploy\\app.7z"
  content_type = "application/x-7z-compressed"
}

output "instance_public_ip" {
  value = aws_instance.react_server.public_ip
}