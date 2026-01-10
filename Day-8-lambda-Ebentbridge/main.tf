# create Custom iam role 
resource "aws_iam_role" "custom_lambda_role" {
  name = "custom_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# create lambda function
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.custom_lambda_role.arn
  handler       = "index.handler"
  runtime = "nodejs18.x"
  filename      = "lambda_function.zip"

  source_code_hash = filebase64sha256("lambda_function.zip")
}

# attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.custom_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# create eventbridge rule
resource "aws_cloudwatch_event_rule" "every__minute_rule" {
  name                = "every_minute_rule"
  description         = "Triggers every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}


# Add lambda target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every__minute_rule.name
  target_id = "my_lambda_target"
  arn       = aws_lambda_function.my_lambda.arn
}

# allow eventbridge to invoke lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.every__minute_rule.arn
}

