resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  
  tags = {
    Name        = "My bucket"
  }
}

resource "aws_s3_object" "object" {
  bucket       = aws_s3_bucket.bucket.id
  key          = var.file
  source       = var.file_source
}


resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.file
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::yashdongardiyebucket/*"
    }
  ]
})
}





