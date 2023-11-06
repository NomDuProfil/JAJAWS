/*

# Author information

Name: NomDuProfil

# Module information

This module can create a basic serverless website.

# Variables

| Name        | Type   | Description             |
|-------------|--------|-------------------------|
| bucket_name | string | Name for the S3 bucket. |
*/

module "jajaws_basic_serverless_website_module_1" {
    source      = "./modules/basic_serverless_website_module_1"
    bucket_name = "jajaws-example"
}