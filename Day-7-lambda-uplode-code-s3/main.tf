# create s3 bucket
resource "aws_s3_bucket" "name" {
  bucket = "my-lambda-function-bucket-1234567890"

}

# upload lambda zip file to s3 bucket
resource "aws_s3_object" "app_zip" {
  bucket = aws_s3_bucket.name.id
  key    = "app.zip"
  source = "app.zip"
}

# create iam role for lambda
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# create lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = "my_lambda_function"
  s3_bucket = aws_s3_bucket.name.id
  s3_key    = aws_s3_object.app_zip.key
  handler = "app.lambda_handler"
  runtime = "python3.8"
  role   = aws_iam_role.iam_for_lambda.arn
  timeout     = 900
  memory_size = 128

  source_code_hash = filebase64sha256("app.zip")
  
}


