# JAJAWS

JAJAWS aims to provide tips for rapidly deploying an AWS infrastructure with Terraform.

Before getting started, it is recommended to read the 'Recommended Infrastructure' section, which will serve as the foundation for all the sections provided.

Table of Contents
=================

- [Recommended Infrastructure](Installation/README.md#recommended-infrastructure)
  - [Technologies](Installation/README.md#technologies)
    - S3 Bucket
    - CodeBuild
    - CodePipeline
    - CodeCommit
  - [Visualization of the Concept](Installation/README.md#visualization-of-the-concept)
  - [Description of the section](Installation/README.md#description-of-the-section)
  - [S3 Bucket](Installation/README.md#s3-bucket)
  - [CodeCommit](Installation/README.md#codecommit)
    - [Creation of the CodeCommit](Installation/README.md#creation-of-the-codecommit)
    - [Cloning the CodeCommit Repository](Installation/README.md#cloning-the-codecommit-repository)
  - [CodeBuild](Installation/README.md#codebuild)
    - [CodeBuild Configuration](Installation/README.md#codebuild-configuration)
    - [CodeBuild Permissions](Installation/README.md#codebuild-permissions)
  - [CodePipeline](Installation/README.md#codepipeline)
    - [Creation of the CodePipeline](Installation/README.md#creation-of-the-codepipeline)
    - [CodePipeline Configuration](Installation/README.md#codepipeline-configuration)
  - [The First Push](Installation/README.md#the-first-push)
    - [Buildspec](Installation/README.md#buildspec)
    - [Provider](Installation/README.md#provider)
    - [Push](Installation/README.md#push)
  - [Conclusion](Installation/README.md#conclusion)
- [Serverless Website](Serverless%20Website/README.md#serverless-website)
  - [Technologies](Serverless%20Website/README.md#technologies)
    - S3 Bucket
    - Cloudfront
    - Route53
    - ACM (AWS Certificate Manager)
  - [Visualization of the Concept](Serverless%20Website/README.md#visualization-of-the-concept)
  - [Description of the section](Serverless%20Website/README.md#description-of-the-section)
  - [Module 1 : Basic configuration (S3 + CloudFront)](Serverless%20Website/README.md#module-1--basic-configuration-s3--cloudfront)
    - [Variables](Serverless%20Website/README.md#module-1--variables)
    - [S3 bucket](Serverless%20Website/README.md#module-1--s3-bucket)
    - [CloudFront](Serverless%20Website/README.md#module-1--cloudfront)
      - [CloudFront Distribution](Serverless%20Website/README.md#module-1--cloudfront-distribution)
      - [CloudFront Origin](Serverless%20Website/README.md#module-1--cloudfront-origin)
      - [CloudFront Custom Error Response](Serverless%20Website/README.md#module-1--cloudfront-custom-error-response)
      - [CloudFront Default Cache Behavior](Serverless%20Website/README.md#module-1--cloudfront-default-cache-behavior)
      - [CloudFront Restrictions](Serverless%20Website/README.md#module-1--cloudfront-restrictions)
      - [CloudFront Viewer Certificate](Serverless%20Website/README.md#module-1--cloudfront-viewer-certificate)
    - [Declaration and deployment](Serverless%20Website/README.md#module-1--declaration-and-deployment)
    - [Test](Serverless%20Website/README.md#module-1--test)
  - [Module 2  : Adding a Route 53 domain](Serverless%20Website/README.md#module-2--adding-a-route-53-domain)
    - [Variables](Serverless%20Website/README.md#module-2--variables)
    - [S3 bucket](Serverless%20Website/README.md#module-2--s3-bucket)
    - [CloudFront](Serverless%20Website/README.md#module-2--cloudfront)
    - [AWS Certificate Manager (SSL Certificate)](Serverless%20Website/README.md#module-2--aws-certificate-manager-ssl-certificate)
    - [Route 53](Serverless%20Website/README.md#module-2--route-53)
    - [Declaration and deployment](Serverless%20Website/README.md#module-2--declaration-and-deployment)
