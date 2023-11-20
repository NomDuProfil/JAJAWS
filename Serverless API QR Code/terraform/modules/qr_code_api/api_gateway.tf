data "template_file" "jajaws_qr_code_api_swagger" {
    template        = "${file("${var.path_swagger}")}"

    vars = {
        uri_start   = "arn:aws:apigateway:${data.aws_region.aws_region_information.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${data.aws_region.aws_region_information.name}:${data.aws_caller_identity.aws_information.account_id}:function:",
        uri_end     = "/invocations"
    }
}

resource "aws_api_gateway_rest_api" "jajaws_qr_code_api" {
    name    = var.name_api
    body    = data.template_file.jajaws_qr_code_api_swagger.rendered
    endpoint_configuration {
        types = ["REGIONAL"]
    }
}

resource "aws_api_gateway_deployment" "jajaws_qr_code_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.jajaws_qr_code_api.id

  triggers    = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.jajaws_qr_code_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "jajaws_qr_code_api_stage" {
  deployment_id = aws_api_gateway_deployment.jajaws_qr_code_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.jajaws_qr_code_api.id
  stage_name    = "production"
}

resource "aws_api_gateway_api_key" "jajaws_qr_code_api_key" {
  name = "${var.name_api}_default_api_key"
}

resource "aws_api_gateway_usage_plan" "jajaws_qr_code_api_usage_plan" {
  name         = "${var.name_api}-usage-plan"
  description  = "Usage plan ${var.name_api}"

  api_stages {
    api_id = aws_api_gateway_rest_api.jajaws_qr_code_api.id
    stage  = aws_api_gateway_stage.jajaws_qr_code_api_stage.stage_name
  }

  quota_settings {
    limit  = 100
    period = "WEEK"
  }
}

resource "aws_api_gateway_usage_plan_key" "jajaws_qr_code_api_usage_plan_key" {
  key_id        = aws_api_gateway_api_key.jajaws_qr_code_api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.jajaws_qr_code_api_usage_plan.id
}