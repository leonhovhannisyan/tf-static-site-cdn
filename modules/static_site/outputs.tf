output "bucket_name" {
  value       = aws_s3_bucket.site.bucket
  description = "S3 bucket name for static site content"
}

output "cloudfront_url" {
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}"
  description = "CloudFront distribution URL"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.cdn.id
  description = "CloudFront distribution ID"
}