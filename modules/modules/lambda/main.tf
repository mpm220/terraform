resource "aws_lambda_function" "lambda-with-role" {
    function_name = var.function_name
    role          = aws_iam_role.iam_for_lambda.arn
    handler       = var.handler      # Ensure handler is passed
    runtime       = var.runtime      # Ensure runtime is passed
    filename      = var.filename
    ephemeral_storage {
        size = var.size # Min 512 MB and the Max 10240 MB
    }

    depends_on = [aws_iam_role.iam_for_lambda]
}