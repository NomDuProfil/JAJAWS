/*

# Author information

Name: NomDuProfil

# Module information

This module can create an API that will generate QR Code.

# Variables

| Name         | Type         | Description                                        |
|--------------|--------------|----------------------------------------------------|
| name_api     | string       | Name for the API.                                  |
| path_swagger | string       | Path to the swagger file.                          |
| path_base    | string       | Path to the folder that contains the lambda codes. |
| endpoints    | list(object) | Lambda mapping with the path_base.                 |
*/

/*
  IMPORTANT : GO TO THE LAYERS FOLDER AND EXECUTE "jajaws_generate_layer.sh" BEFORE STARTING !
  It will gives you the jajaws_qr_code_layer.zip that we use to generate QR Code.
*/

resource "aws_lambda_layer_version" "lambda_layer" {
  filename          = "./layers/jajaws_qr_code_layer.zip"
  layer_name        = "jajaws_qr_code_layer"

  source_code_hash  = filebase64sha256("./layers/jajaws_qr_code_layer.zip")
}

module "jajaws_qr_code_api" {
    source          = "./modules/qr_code_api"
    name_api        = "jajaws_example"
    path_swagger    = "./api_swagger/qr_code_api/swagger.yaml"
    path_base       = "./lambda_codes/api_qr_code/"
    endpoints       = [
                        {
                            endpoint_name = "jajaws_example"
                            timeout = 10
                            layers = [aws_lambda_layer_version.lambda_layer.arn]
                        }
                      ]
}