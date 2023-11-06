/*

# Author information

Name: NomDuProfil

# Module information

This module can create a basic serverless website.

# Variables

| Name        | Type   | Description             |
|-------------|--------|-------------------------|
| bucket_name | string | Name for the S3 bucket. |
| domain_name | string | Domain name.            |
*/

module "jajaws_route53_serverless_website" {
    source      = "./modules/route53_serverless_website_module_2"
    bucket_name = "jajaws-example"
    domain_name = "example.com"
}