

resource "aws_iam_policy" "s3_read_policy" {
  name        = "ec2-s3-read-policy"
  description = "Allow EC2 to read from the S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        #Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/${aws_s3_object.react_app_zip.key}*"
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/*"  # Replace with your bucket name and object path
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "react_bucket_policy" {
  bucket = aws_s3_bucket.my_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        #Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/${aws_s3_object.react_app_zip.key}*"
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/app.7z"
        Principal = "*" # Optional: Define specific principal, e.g., IAM Role or EC2 Instance
      },
      {
        Effect    = "Allow"
        Action    = "s3:PutObject"
        #Resource  = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/${aws_s3_object.react_app_zip.key}*"
        Resource = "arn:aws:s3:::${aws_s3_bucket.my_s3.id}/app.7z"
        Principal = "*"
      },
    ]
  })
}