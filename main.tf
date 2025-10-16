# IAM role for Lambda execution
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "${var.name_prefix}_executor"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_role_policy_attachment" "basic_execution_role" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "iam_role_access_permissions" {
  count  = var.additional_permissions != "" ? 1 : 0
  name   = "${var.name_prefix}_permissions"
  policy = var.additional_permissions
}

resource "aws_iam_role_policy_attachment" "iam_role" {
  count      = var.additional_permissions != "" ? 1 : 0
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_role_access_permissions.arn
}
