resource "aws_iam_role" "lambda_role" {
  name = "terraform-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = "terraform-lambda-function"
  runtime       = "nodejs18.x"
  handler       = "index.handler"
  timeout =  10
  memory_size = 128

  filename = "lambda_function.zip"

  source_code_hash =  filebase64sha256("lambda_function.zip") 

  role = aws_iam_role.lambda_role.arn

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_attachment
  ]
}
