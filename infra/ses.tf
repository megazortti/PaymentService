resource "aws_ses_email_identity" "sender" {
  email = "pagamentos@mazzotti.app"
}

resource "aws_iam_policy" "ses_send" {
  name = "LambdaSESSendPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_ses_email_identity" "victor_email" {
  email = "mazzotti.vlm@gmail.com"
}

resource "aws_iam_role_policy_attachment" "lambda_ses" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.ses_send.arn
}
