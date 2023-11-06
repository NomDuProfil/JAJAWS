resource "aws_s3_bucket" "jajaws_s3" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "jajaws_s3_public" {
  bucket = aws_s3_bucket.jajaws_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "jajaws_s3_policy_allow_cloudfront" {
    statement {
      principals {
        type        = "AWS"
        identifiers = [aws_cloudfront_origin_access_identity.jajaws_cloudfront_s3_oia.iam_arn]
      }
      actions = [
        "s3:GetObject"
      ]
      resources = [
        "${aws_s3_bucket.jajaws_s3.arn}/*"
      ]
    }
}

resource "aws_s3_bucket_policy" "jajaws_s3_policy" {
  bucket = aws_s3_bucket.jajaws_s3.id
  policy = data.aws_iam_policy_document.jajaws_s3_policy_allow_cloudfront.json
}