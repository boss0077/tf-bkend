output "s3_bucket" {
  value       = module.s3_bucket.s3_bucket_id
  description = "Name of the S3 which holds backend remotely."
}

output "dynamodb_table" {
  value       = module.dynamodb_table.dynamodb_table_id
  description = "Database which manages state locking for trfm"
}