module "lambda-with-role"{
  source = "./modules/lambda"
  function_name = "pointless"
  handler = "main.main"
  runtime = "python3.11"
  size = 512
  filename = "./zipper.zip"
}