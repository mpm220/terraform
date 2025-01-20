output "lambda_arn" {
  value = aws_lambda_function.lambda-with-role.arn
}

output "lambda_name" {
  value = aws_lambda_function.lambda-with-role.function_name
}