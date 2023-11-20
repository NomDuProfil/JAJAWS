resource "aws_iam_role" "iam_for_lambda" {
  for_each            = {for endpoint in var.endpoints: endpoint.endpoint_name => endpoint}
  
  name                = "jajaws_iam_for_lambda_${each.key}"
  assume_role_policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "JAJAWSQRAPI"
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "lambda_permission" {
    for_each      = {for endpoint in var.endpoints: endpoint.endpoint_name => endpoint}

    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_zip_dir[each.key].function_name
    principal     = "apigateway.amazonaws.com"

    source_arn    = "${aws_api_gateway_rest_api.jajaws_qr_code_api.execution_arn}/*/*"
}

data "archive_file" "lambda_zip_dir" {
    for_each    = {for endpoint in var.endpoints: endpoint.endpoint_name => endpoint}

    type        = "zip"
    output_path = "./${each.key}.zip"
    source_dir  = "${var.path_base}${each.key}"
}

resource "aws_lambda_function" "lambda_zip_dir" {
    for_each            = {for endpoint in var.endpoints: endpoint.endpoint_name => endpoint}

    filename            = data.archive_file.lambda_zip_dir[each.key].output_path
    source_code_hash    = data.archive_file.lambda_zip_dir[each.key].output_base64sha256
    function_name       = each.key
    handler             = "${each.key}.lambda_handler"
    role                = aws_iam_role.iam_for_lambda[each.key].arn
    timeout             = each.value.timeout
    runtime             = "python3.9"

    layers              = each.value.layers
}